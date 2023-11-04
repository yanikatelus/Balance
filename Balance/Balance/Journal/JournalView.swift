//
//  JournalView.swift
//  Balance
//
//  Created by Yanika Telus on 10/21/23.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    //FUTURE: Take user input on first login
    @State private var userName = "User"
    @State private var Today = formatDateNote(Date())
    
    @State private var viewIsShowing = false//for sheets
    
    var body: some View {
        NavigationView {
            VStack(){

                UserGreetingView(username: $userName)//will need to pulll this from authentication
                    .padding(.vertical, 12)
                    
                Text("\(Text("Today").font(Font.custom("Avenir", size: 18)).fontWeight(.medium)), \n \(Today)")
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .font(
                    Font.custom("Avenir", size: 12)
                    .weight(.medium)
                )
                .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))


                .padding(.bottom, 12)
                
                CheckUpButtonView(viewIsShowing: $viewIsShowing)
                
                HStack {
                    Spacer()
                    NavigationLink{
                        ListJournalView()
                    }label: {
                        Text("All Journal Entries")
                        Image(systemName: "book.circle")
                            .fontWeight(.medium)
                            .font(Font.custom("Avenir", size: 20))
                    }
                    .padding(.vertical, 4)
                    .font(Font.custom("Avenir", size: 16))
                    .foregroundColor(Colors.PURPLE3)
                    .fontWeight(.heavy)
                }
                .padding(.bottom, 12)
                
                QuoteCardView()
            }//Vstack
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 12)
        .background(.white)
        }//NavigationView()
        .navigationBarHidden(true)
    }//body
}//JournalView

#Preview {
    JournalView()
        .modelContainer(for: Notes.self, inMemory: true)
}

struct UserGreetingView: View {
    
    @Binding var username: String
    
    var body: some View {
        Text("\(getTimeOfDay()) \n\(username)")
            .font(
                Font.custom("Avenir", size: 24)
                    .weight(.bold)
            )
            .foregroundStyle(Colors.GRAY)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    func getTimeOfDay() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        var timeOfDay = ""
        
        let currentTime = Date()
        let hourString = dateFormatter.string(from: currentTime)
        let hourAsInt = Int(hourString) ?? -1
        
        switch hourAsInt {
            case 6...11:
                timeOfDay = "Good Morning,"
            case 12...17:
                timeOfDay = "Good Afternoon,"
            case 18...24:
                timeOfDay = "Good Evening,"
            default:
                timeOfDay = "Hello!"
        }
        return timeOfDay
    }//end of getTimeOfDay
    
}// end of UserGreetingView

struct CheckUpButtonView: View {
    
    @Binding var viewIsShowing: Bool
    
    var body: some View {
        Button {
            withAnimation {
                viewIsShowing = true
            }
        } label:{
            VStack {
                HStack {
                    Image(systemName: "face.smiling")
                        .fontWeight(.medium)
                    Text("Daily Journal")
                }
                .font(Font.custom("Avenir", size: 18))
                .foregroundColor(Colors.GRAY)
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.vertical, 8)
                
                Text("How Are you feeling today?")
                    .font(
                        Font.custom("Avenir", size: 12)
                        .weight(.medium)
                    )
                    .tint(Colors.PURPLE3)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 26)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 2)
            .tint(.black)
            .fullScreenCover(isPresented: $viewIsShowing){
                EmotionView(viewIsShowing: $viewIsShowing)
            }
        }
    }
}
