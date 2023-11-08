//
//  EmotionView.swift
//  Balance
//
//  Created by Yanika Telus on 10/29/23.
//
/// environment object tutorial https://www.youtube.com/watch?v=lxaEAHNmhY4&ab_channel=PaulHudson
import SwiftUI
import SwiftData

struct EmotionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var userEmoticon = "Indifferent"
    @State private var selectedOption: RadioOption? = RadioOption.option3
    
    @Binding var viewIsShowing: Bool //For sheet1
    @State private var isactView = false
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
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
                        dismiss()// this needs to be change to go to home screen
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Colors.BLACK.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .padding(12)
                }//Hstack
            }//Hstack
            EmotionIconView(selectedOption: $selectedOption, userEmoticon: $userEmoticon, isActView: $isactView, viewIsShowing: $viewIsShowing)
        }
        .background(.white)
    }//Bpdy
}//end

#Preview {
    EmotionView(viewIsShowing: .constant(false))
}

struct EmotionIconView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedOption: RadioOption?
    @Binding var userEmoticon: String
    
    @State private var clicked: Bool = false
    @Binding var isActView: Bool//sheet 2
    @Binding var viewIsShowing: Bool//Sheet 1
    
    var body: some View {
        HStack {
            Text("How are you feeling today?")
                .font(Font.custom("Avenir", size: 24))
                .foregroundColor(Colors.PURPLE3)
                .fontWeight(.heavy)
                .frame(height: 18, alignment: .leading)
            .padding(12)
            Spacer()
        }
        Spacer()
        //display and save the selected emotion
        if let selected = selectedOption {
            Image(selected.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Text(selected.imageName.uppercased())
                .font( Font.custom("Avenir", size: 24)
                    .weight(.medium) )
                .foregroundColor(Color(red: 0.7, green: 0.66, blue: 0.87))
                .padding()
        }else{
            Text(" ")
                .font(.title)
        }
        HStack{
            ForEach(RadioOption.allCases.reversed()) { option in
                Image(option.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .background(selectedOption == option ? Color.white : Color.clear )
                    .clipShape(Circle())
                    .shadow(radius: selectedOption == option ? 10: 0)
                    .onTapGesture{
                        selectedOption = option
                        userEmoticon = option.imageName
                        clicked = true
                    }//onTapGesture
            }//ForEach
        }//HStack
        
        Spacer()
        
        Button(action: {
            self.isActView = true
        }, label: {
            Text("Continue")
        })
        .frame( width: 300, height: 20)
        .padding(10)
        .font(Font.custom("Avenir", size: 16)
            .weight(.semibold)
        )
        .foregroundColor(.black)
        .background(clicked ? Colors.PURPLE2.opacity(0.6) : .gray)
        .cornerRadius(10)
        .padding(.horizontal)
        .disabled(!clicked)
        .fullScreenCover(isPresented: $isActView){
            ActivityEntryView(userEmoticon: $userEmoticon, isActView: $isActView, viewIsShowing: $viewIsShowing )
        }
    }//body
    
}//EmotionRowView
