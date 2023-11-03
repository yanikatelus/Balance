//
//  ItemEntryView.swift
//  Balance
//
//  Created by Yanika Telus on 10/30/23.
//

import SwiftUI

struct ActivityEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var selectedActivities: [String] = []
    @Binding var userEmoticon: String
    
    @State private var clicked: Bool = false
    @State private var isNextView = false
    
    let rows = [GridItem(.adaptive(minimum: 80))]

    var body: some View {
        VStack {
            SubNavView()//CHANGE TO OTHER ACTION
            
            HStack {
                Text("What's making you feel \(userEmoticon)?")
                    .font(Font.custom("Avenir", size: 20))
                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.8))
                    .fontWeight(.heavy)
                    .frame(height: 18, alignment: .leading)
                .padding(12)
                Spacer()
            }
            Spacer()
            
            HStack {
                Text("Select up to 3")
                    .font(Font.custom("Avenir", size: 18))
                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51).opacity(0.6))
                    .fontWeight(.medium)
                    .frame(height: 18, alignment: .leading)
                .padding(12)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 20) {
                    ForEach(Activities.allCases) { act in
                        VStack {
                            Image(act.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    clicked = true
                                    if let index = selectedActivities.firstIndex(of: act.rawValue) {
                                        selectedActivities.remove(at: index) // Deselect
                                    } else if selectedActivities.count < 3  {
                                        selectedActivities.append(act.rawValue) // Select
                                    }
                                    print(selectedActivities)
                                }
                            Text(act.rawValue)
                        }
                        .frame(width: 70, height: 80)
                        .padding(6)
                        .shadow(radius: selectedActivities.contains(act.rawValue) ? 10: 0)
                        .background(selectedActivities.contains(act.rawValue) ? Colors.PURPLE.opacity(0.4) : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }//Foreach
                }//LazyHGrid
            }//Scrolview
            .frame(width: .infinity, height: 250)
            Spacer()
            
            VStack{
                Button(action: {
                    self.isNextView.toggle()
                }, label: {
                    Text("Continue")
                        .frame( width: 300, height: 20)
                        .padding(10)
                        .font(Font.custom("Avenir", size: 16)
                            .weight(.semibold)
                        )
                        .foregroundColor(.black)
                        .background(clicked ? Colors.PURPLE2.opacity(0.6): .gray)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
                .disabled(!clicked)
                .fullScreenCover(isPresented: $isNextView) {
                    TextEntryView(userEmoticon: $userEmoticon, selectedActivities: $selectedActivities)
                }
            }
        }//VStack
    }//body
}//End

enum Activities: String, CaseIterable, Identifiable, Codable {
    case option1 = "Work"
    case option2 = "Family"
    case option3 = "Friends"
    case option4 = "School"
    case option5 = "Food"
    case option6 = "Health"
    case option7 = "Travel"
    case option8 = "Hobbies"
    case option9 = "Weather"
    case option10 = "Music"

    var id: String { rawValue }
}

#Preview {
    ActivityEntryView(selectedActivities: [], userEmoticon: .constant(""))
}

struct SubNavView: View {
    @Environment(\.dismiss) var dismiss
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
        }
    }
}
