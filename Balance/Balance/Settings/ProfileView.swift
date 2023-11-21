//
//  ProfileView.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var name: String = "Chiara Telus"
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var avatarImage: UIImage?
    @State private var profilePick: PhotosPickerItem? //<- need to convert to a ui image
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section{
                    HStack{
                       
//                        Image("dog")
                        Image(uiImage: avatarImage ?? UIImage(resource: .numb ))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 80)
                            .padding(.horizontal, 4)
                            .shadow(radius: 10)
                        
                        
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
                        
                    }//HStack

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
                        
                    }label:{
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: Colors.PURPLE2)
                    }
                }
                
            }//Vstack
        }
        
    }//body
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
