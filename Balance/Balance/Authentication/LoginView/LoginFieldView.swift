//
//  LoginFieldView.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//

/**
 A view that displays an input field for login purposes.

 This view includes a title, a text input field (either secure or regular), and a placeholder.
 
 - Parameters:
   - text: A binding to the text value entered by the user.
   - title: The title displayed above the input field.
   - placeholder: The placeholder text displayed inside the input field.
   - isSecureField: A boolean indicating whether the input field is secure (e.g., for passwords).
 
 - Note: The appearance and style of the input field are customized for the Balance app.
 */

import SwiftUI

struct LoginFieldView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSercureField = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(Font.custom("Avenir", size: 18))
                .fontWeight(.heavy)
                .foregroundStyle(Colors.PURPLE3)
                .padding(0)
            
            if isSercureField {
                SecureField(placeholder, text: $text)
                    .font(Font.custom("Avenir", size: 18))
                    .padding(12)
                    .foregroundColor(Colors.BLACK)
                    .fontWeight(.medium)
                    .frame(width: 365)
                    .background(Colors.PURPLE.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 4)
            } else {
                TextField(placeholder, text: $text)
                    .font(Font.custom("Avenir", size: 18))
                    .padding(12)
                    .foregroundColor(Colors.BLACK)
                    .fontWeight(.medium)
                    .frame(width: 365)
                    .background(Colors.PURPLE.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 4)
            }

        }//Vsatck
    }//Body
}

#Preview {
    LoginFieldView(text: .constant(""), title: "Email Address", placeholder: "abc@example.com")
}
