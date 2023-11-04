//
//  UserReviewView.swift
//  Balance
//
//  Created by Yanika Telus on 11/1/23.
//

import SwiftUI
import SwiftData

struct UserReviewView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var notes: [Notes]
    
    @Binding var selectedActivities: [String]
    @Binding var userEmoticon: String
    @Binding var userTitle: String
    @Binding var userContent: String
    
    
    @Binding var isNextView: Bool// sheet 4
    @Binding var isTextView: Bool //sheet 3
    @Binding var isActView: Bool//sheet 2
    @Binding var viewIsShowing: Bool//Sheet 1
    
    var body: some View {
        VStack {
            JournalNavigationView(userEmoticon: $userEmoticon, isNextView: $isNextView, isTextView: $isNextView, isActView: $isActView, viewIsShowing: $viewIsShowing )//hstack top row
            
            
            Text(formatDateNote(Date()))
                .font(Font.custom("Avenir", size: 20))
                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                .bold()
                .padding(12)
        }
        Spacer()
        
        VStack {
            Text("Activities")
                .font(Font.custom("Avenir", size: 30))
                .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.6))
                .fontWeight(.heavy)
                .frame(height: 18)

            HStack{
                  ForEach(selectedActivities, id: \.self) { act in
//                ForEach(1...3, id: \.self){ _ in
                    HStack{
                          Image(act)
//                        Image("Family")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Colors.PURPLE3)
                            .frame(width: 30, height: 30)
                        
                          Text(act)
//                        Text("Family")
                    }//HStack
                    .frame(height: 25)
                    .padding(12)
                    .shadow(radius: 10)
                    .background(Colors.PURPLE.opacity(0.7))
                    .foregroundColor(Colors.PURPLE3)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer()
                }//foreach

            }//Hstack
        }//VStack
        .padding(12)
        
        
        //TITLE
        VStack{
            
            Text(userTitle)
//            Text("This is my temporary tittle")
                .padding(12)
                .font(Font.custom("Avenir", size: 18))
                .foregroundColor(Colors.BLACK.opacity(0.8))
                .fontWeight(.medium)
                .frame(width: 365)
                .background(Colors.PURPLE.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.08), radius: 4, x: 2, y: 4)
                
        }//vstack
        .padding(12)
        
        
        
        //CONTENT
        VStack{
            ScrollView(.vertical) {
                Text(userContent)
            }
            .padding(12)
            .font(Font.custom("Avenir", size: 18))
            .foregroundColor(Colors.BLACK.opacity(0.8))
            .fontWeight(.medium)
            .frame(width: 365, height: 360, alignment: .leading)
            .background(Colors.PURPLE.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.12), radius: 4, x: 2, y: 4)

        }//vstack
        .padding(12)
        
        VStack{
            Button(action: {
                addNote()
            }, label: {
                Text("Record Today's Feeling")
                    .frame( width: 300, height: 20)
                    .padding(10)
                    .font(Font.custom("Avenir", size: 16)
                        .weight(.semibold)
                    )
                    .foregroundColor(.black)
                    .background(Colors.PURPLE2.opacity(0.6))
                    .cornerRadius(10)  // Optional: to round the corners
                    .padding(.horizontal)
            })
        }
        
    }//BODY
    
    private func addNote() {
        withAnimation {
            let newItem = Notes(timestamp: formatDateNote(Date()), title: userTitle, content: userContent, emoticon: userEmoticon, activities: selectedActivities)
            
            modelContext.insert(newItem)
            userTitle = ""
            userContent = ""
            selectedActivities = []
            
            //may need to changethese to one source of truth
            viewIsShowing = false
            isActView = false
            isTextView = false
            isNextView = false
            
            
        }
    }//addItem
}//END

#Preview {
    UserReviewView(selectedActivities: .constant([]), userEmoticon: .constant(""), userTitle: .constant(""), userContent: .constant(""), isNextView: .constant(false), isTextView: .constant(false), isActView: .constant(false), viewIsShowing: .constant(false))
}

struct JournalNavigationView: View {
    @Binding var userEmoticon: String
    @Environment(\.dismiss) var dismiss
    
    @Binding var isNextView: Bool// sheet 4
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
            
            Image(userEmoticon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Colors.PURPLE)
                .frame(width: 100, height: 100)
            
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
        }
    }
}
