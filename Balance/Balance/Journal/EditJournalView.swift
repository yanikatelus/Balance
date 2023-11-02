//
//  EditJournalView.swift
//  Balance
//
//  Created by Yanika Telus on 10/22/23.
//

import SwiftUI
import SwiftData

struct EditJournalView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Query private var notes: [Notes]

    @State private var userTitle = ""
    @State private var userContent = ""
    @State private var userEmoticon = "Indifferent"
    
    @State private var selectedOption: RadioOption? = RadioOption.option3
    @State private var activities: [String] = []
    

    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .topTrailing)
                        .padding(.horizontal)
                        .foregroundColor(.purple)
                })
            }
            .frame(width: .infinity, alignment: .trailing)
            
            ///emotion images in row
            EmotionRowView(selectedOption: $selectedOption, userEmoticon: $userEmoticon)
//            ActivityEntryView(selectedActivities: $activities, userEmoticon: $userEmoticon)
            
            TextField("Enter your text", text: $userTitle)
                .padding()
                .font(.title2)
                .bold()
                .foregroundColor(.purple)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.purple, lineWidth: 1)
                        .background(.purple.opacity(0.2))
                )
                .padding()
            
            
            ZStack {
                TextEditor(text: $userContent)
                    .bold()
                    .frame(minHeight: 200, idealHeight: 200)
                    .foregroundColor(.purple)
                    .cornerRadius(24)
                    .shadow(color: .purple.opacity(0.3), radius: 10)
                    .padding()
            }//Zstack
            .frame(minHeight: 200, idealHeight: 200)
            
            Button(action: {
                addItem()
            }, label: {
                Text("Add")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.purple.opacity(0.6))
                    .cornerRadius(10)  // Optional: to round the corners
                    .padding(.horizontal)
            })
            
        }//VStack
    }//body
    
    private func isValidInput() -> Bool {
        return !userEmoticon.isEmpty && !userTitle.isEmpty && !userContent.isEmpty
    }
    
    /**
     Adds a new note item with the current user's input values.
     
     - Note: This function also resets the `userTitle`, `userContent`, and `userEmoticon` to an empty string after adding the item.

     - Author:  created on creation of project. Edited: Yanika
    */
    private func addItem() {
        withAnimation {
            //UNABLE TO EXPLICITLY Add ARRAY TO SWIFTDATA?
            let newItem = Notes(timestamp: formatDateNote(Date()), title: userTitle, content: userContent, emoticon: userEmoticon, activities: activities)
            
//            let newItem = Notes(timestamp: formatDateNote(Date()), title: userTitle, content: userContent, emoticon: userEmoticon)
            modelContext.insert(newItem)
            
            userTitle = ""
            userContent = ""
            activities = []
            dismiss()
        }
    }//addItem

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    } //deleteItems
}

/**
 Represents the various emoticon choices available for the user to select.

 Each case corresponds to a unique emoticon with a distinct `imageName`. This enum provides a strongly-typed
 and structured way to handle and represent emoticon selections in the application.
 
 - Note: Ensure that each `imageName` corresponds to a valid asset in the project.
 
 - Author: Yanika
*/
enum RadioOption: Int, CaseIterable, Identifiable, Codable {
    case option1, option2, option3, option4, option5

    var id: Int { rawValue }

    var imageName: String {
        switch self {
            case .option1:
                return "depressed"
            case .option2:
                return "sad"
            case .option3:
                return "Indifferent"
            case .option4:
                return "happy"
            case .option5:
                return "estatic"
        }
    }
}//Enum

#Preview {
    EditJournalView()
        .modelContainer(for: Notes.self, inMemory: true)
}

struct EmotionRowView: View {
    @Binding var selectedOption: RadioOption?
    @Binding var userEmoticon: String

    var body: some View {
        
        //display and save the selected emotion
        if let selected = selectedOption {
            Text(selected.imageName.uppercased())
                .font(.title)
                .foregroundStyle(.purple)
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
                    }//On tap gesture
            }//foreach
        }//Hstack
    }//body
}//EmotionRowView
