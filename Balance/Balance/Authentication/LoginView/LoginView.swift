//
//  LoginView.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""//shoudl this be hidden?
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Image("happy")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.top,24)
                Text("Balance")
                    .font(
                        Font.custom("Avenir", size: 28)
                        .weight(.heavy)
                    )
                    .foregroundColor(Colors.PURPLE3)

                //email form field
                LoginFieldView(text: $email, title: "Email", placeholder: "abc@example.com")
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)//not wokring in preview
                    .autocapitalization(.none)// will be depricated
                    .padding(.top, 24)
                
                //password form field
                LoginFieldView(text: $password, title: "Password", placeholder: "•••••••", isSercureField: true)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)
                    .autocapitalization(.none)
                
                Button{
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }//task
                } label: {
                    Text("Sign in")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 18)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .background(Colors.PURPLE3)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0.54, green: 0.58, blue: 0.62).opacity(0.12), radius: 10, x: 0, y: 2)
                }
                .padding()
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                Spacer()
                NavigationLink{
                    SignUpView()
                        .navigationBarBackButtonHidden()
                }label: {
                    Text("Dont’t have an account? Sign up here")
                        .font(
                            Font.custom("Avenir", size: 18)
                            .weight(.medium)
                        )
                        .foregroundColor(Colors.PURPLE3)
                }
            }//Vstack
            .padding(.horizontal, 12)
        }//Navstack
    }//body
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

#Preview {
    LoginView()
}
