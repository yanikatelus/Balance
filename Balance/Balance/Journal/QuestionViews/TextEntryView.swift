//
//  TitleView.swift
//  Balance
//
//  Created by Yanika Telus on 10/30/23.
//

import SwiftUI

struct TextEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var userEmoticon: String
    @Binding var selectedActivities: [String]
    
    @State private var userTitle = ""
    @State private var userContent = ""
    
    @State private var isNextView = false// sheet 4
    @Binding var isTextView: Bool //sheet 3
    @Binding var isActView: Bool//sheet 2
    @Binding var viewIsShowing: Bool//Sheet 1
    
    var body: some View {
        HStack {
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(12)
                    .background(Colors.BLACK.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(12)
            
            Spacer()
            
            Button(action: {
                
                viewIsShowing = false
                isActView = false
                isTextView = false
                isNextView = false
                
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(12)
                    .background(Colors.BLACK.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(12)
        }//hstack top row
        
        HStack {
            Text("Let's record your thoughts")
                .font(Font.custom("Avenir", size: 20))
                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.8))
                .fontWeight(.heavy)
                .frame(height: 18, alignment: .leading)
                .padding(12)
            Spacer()
        }
        
        ZStack {
            TextField("Give your thoughts a title", text: $userTitle)
                .limitText($userTitle, to: 30)
                .padding(12)
                .font(Font.custom("Avenir", size: 18))
                .foregroundColor(Colors.BLACK.opacity(0.8))
                .fontWeight(.medium)
                .frame(width: 365)
                .background(Colors.PURPLE.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 4)
            HStack {
                Spacer()
                Text("\(userTitle.count) /30")
                    .font(Font.custom("Avenir", size: 18))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 24)
            }
        }
        .padding(.vertical, 12)
        
        
        VStack {
            ScrollView {
                ZStack {
                    Colors.PURPLE.opacity(1)
                        .frame(width: 365, height: 360)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    TextEditor(text: $userContent)
                        .opacity(0.5)
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(Colors.BLACK.opacity(0.8))
                        .fontWeight(.medium)
                        .frame(width: 365, height: 360, alignment: .leading)
                        .background(Colors.PURPLE.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
            .font(Font.custom("Avenir", size: 18))
            .foregroundColor(Colors.BLACK.opacity(0.9))
            .fontWeight(.medium)
            .frame(width: 365, height: 360, alignment: .leading)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.12), radius: 4, x: 2, y: 4)
        }//Zstack
        
        Spacer()
        
        VStack{
            Button(action: {
//                self.isNextView.toggle()
                self.isNextView = true
            }, label: {
                Text("Continue")
                    .frame( width: 300, height: 20)
                    .padding(10)
                    .font(Font.custom("Avenir", size: 16)
                        .weight(.semibold)
                    )
                    .foregroundColor(.black)
                    .background(!(userTitle.isEmpty || userContent.isEmpty) ? Colors.PURPLE2.opacity(0.6): .gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
            })
            .disabled(userTitle.isEmpty || userContent.isEmpty)
            .fullScreenCover(isPresented: $isNextView) {
                UserReviewView(selectedActivities: $selectedActivities, userEmoticon: $userEmoticon, userTitle: $userTitle, userContent: $userContent, isNextView: $isNextView, isTextView: $isTextView, isActView: $isActView, viewIsShowing: $viewIsShowing)
            }
        }
    }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue, {
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            })
    }
}


#Preview {
    TextEntryView(userEmoticon: .constant(""), selectedActivities: .constant([]), isTextView: .constant(false), isActView: .constant(false), viewIsShowing: .constant(false))
}
