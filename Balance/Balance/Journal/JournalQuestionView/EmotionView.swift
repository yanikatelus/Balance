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
    @State private var userEmoticon = "Indifferent"
    @State private var selectedOption: RadioOption? = RadioOption.option3
//    @State private var isactView = false
    var body: some View {
        HStack {
            Spacer()
            SubNavView()
        }
        
        EmotionIconView(selectedOption: $selectedOption, userEmoticon: $userEmoticon)
    }
}

#Preview {
    EmotionView()
}

struct EmotionIconView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedOption: RadioOption?
    @Binding var userEmoticon: String
    
    @State private var clicked: Bool = false
    @State private var isActView = false
    var body: some View {
        HStack {
            Text("How are you feeling today?")
                .font(Font.custom("Avenir", size: 20))
                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.8))
                .fontWeight(.heavy)
                .frame(height: 18, alignment: .leading)
            .padding(12)
            Spacer()
        }
        Spacer()
        //display and save the selected emotion
        if let selected = selectedOption {
            Text(selected.imageName.uppercased())
                .font( Font.custom("Avenir", size: 24)
                    .weight(.medium)
                )
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
                    .frame(width: 60, height: 60) // Adjust this size as needed
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
            self.isActView.toggle()
        }, label: {
            Text("Continue")
        })
        //If clicked = true make clickable
        .frame( width: 300, height: 20)
        .padding(10)
        .font(Font.custom("Avenir", size: 16)
            .weight(.semibold)
        )
        .foregroundColor(.black)
        .background(clicked ? Colors.PURPLE2.opacity(0.6) : .gray)
        .cornerRadius(10)  // Optional: to round the corners
        .padding(.horizontal)
        .disabled(!clicked)
        .fullScreenCover(isPresented: $isActView){
            ActivityEntryView( userEmoticon: $userEmoticon)
        }
    }//body
    
}//EmotionRowView
