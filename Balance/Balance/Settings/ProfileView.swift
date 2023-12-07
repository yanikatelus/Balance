//
//  ProfileView.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//
// https://www.youtube.com/watch?v=jCskmh46L-s&ab_channel=SeanAllen
import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var photoLibraryManager = PhotoLibraryManager()
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var avatarImage: UIImage?
    @State private var profilePick: PhotosPickerItem?//<- need to convert to a uiImage image
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        
                        HStack {
                            if photoLibraryManager.permissionStatus == .authorized {
                                PhotosPicker(selection: $profilePick, matching: .any(of: [.images, .screenshots, .depthEffectPhotos])) {
                                    Image(uiImage: avatarImage ?? UIImage(resource: .numb ))
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 80)
                                        .padding(.horizontal, 4)
                                        .shadow(radius: 10)
                                }
                            } else {
                                Button("Request Photo Library Access") {
                                    photoLibraryManager.checkPhotoLibraryPermission()
                                }
                                .backgroundStyle(Colors.PURPLE)
                                .clipShape(Circle())
                                .frame(width: 80)
                                .padding(.horizontal, 4)
                                .shadow(radius: 10)
                            }
                        }
                        .onAppear {
                            if let profileImageUrl = viewModel.currentUser?.profileImageUrl {
                                loadImage(from: profileImageUrl)
                            } else {
                                self.avatarImage = UIImage(named: "numb")
                            }
                        }
                
                        
                        VStack(alignment: .leading) {
                            Text(user.fullname)
//                            Text("Yanika")
                                .foregroundStyle(Colors.PURPLE3)
                                .font(Fonts.TITLE2)
                                .bold()
                                .foregroundStyle(Colors.PURPLE3)
                            
                            Text(user.email)
//                            Text("Yanikatelus@gmail.com")
                                .tint(Colors.PURPLE3)
                                .font(Fonts.TITLE3)
                        }//VStack
                        .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 4)
                    } //HStack
                    .onChange(of: profilePick){ _, _ in
//                        Task{
//                            if let profilePick,
//                               let data = try? await profilePick.loadTransferable(type: Data.self){
//                                if let image = UIImage(data: data){
//                                    avatarImage = image
//                                }
//                            }
//                        }//Task
                        Task {
                            if let profilePick,
                               let data = try? await profilePick.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                avatarImage = image
                                viewModel.uploadProfileImage(image) { result in
                                    switch result {
                                    case .success(let url):
                                        Task {
                                            await viewModel.updateUserProfileImageURL(url)
                                        }
                                    case .failure(let error):
                                        print("Error uploading profile image: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }//Onchange
                }//section
                
                Section("General"){
                    HStack {
                        SettingsRowView(imageName: "gear", title: "version", tintColor: Colors.PURPLE2)
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(Colors.PURPLE2)
                    }
                }
                
                Section("Account"){
                    Button{
                        viewModel.signout()
                    }label:{
                        SettingsRowView(imageName: "arrow.left", title: "Sign Out", tintColor: Colors.PURPLE2)
                    }
                        
                    Button{
                        Task {
                            await viewModel.deleteAccount()
                        }
                    }label:{
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: Colors.PURPLE2)
                    }
                }
                
            }//Vstack
            .alert("Photo Library Access Denied", isPresented: $photoLibraryManager.permissionError) {
                Button("Open Settings", action: openAppSettings)
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Access to your photo library is needed to choose profile pictures.")
            }//Alert
        }//if-let
    }//body
    
    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global(qos: .userInteractive).async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.avatarImage = UIImage(data: data)
                }
            }
        }
    }
}//END

#Preview {
    ProfileView().environmentObject(AuthViewModel())
}


struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image (systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor (tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}
