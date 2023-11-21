//
//  SignUpView.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var confrimPass: String = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
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
            LoginFieldView(text: $email, title: "Email Address", placeholder: "abc@example.com")
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)//not wokring in preview
                .autocapitalization(.none)// will be depricated
                .padding(.top, 24)
            
            //name form field
            LoginFieldView(text: $name, title: "Full Name", placeholder: "John Doe")
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)
                .autocapitalization(.none)
            
            //email form field
            LoginFieldView(text: $password, title: "Password", placeholder: "Enter Password", isSercureField: true)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)//not wokring in preview
                .autocapitalization(.none)// will be depricated
            
            //Confirm password form field
            LoginFieldView(text: $confrimPass, title: "Confirm Password", placeholder: "Confirm Password", isSercureField: true)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.none)
                .autocapitalization(.none)
            
            Button{
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullname: name)
                }
            } label: {
                Text("Sign un")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(Colors.PURPLE3)
                    .cornerRadius(10)
                    .shadow(color: Color(red: 0.54, green: 0.58, blue: 0.62).opacity(0.12), radius: 10, x: 0, y: 2)
            }//button
            .padding()
            
            Spacer()
            
            Button{
                dismiss()
            }label: {
                HStack{
                    Text("Already have an account?")
                        .font(
                            Font.custom("Avenir", size: 18)
                                .weight(.medium)
                        )
                        
                    Text("Log In")
                        .font(
                            Font.custom("Avenir", size: 18)
                                .weight(.heavy)
                        )
                        
                }
                .foregroundColor(Colors.PURPLE3)
                .buttonStyle(.plain)
            }//dismiss button
        }//Vstack
        .padding(.horizontal, 12)
    }//BODY
}//SIGNUPVIEW

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5 && confrimPass == password && !name.isEmpty
    }
}

#Preview {
    SignUpView()
}
