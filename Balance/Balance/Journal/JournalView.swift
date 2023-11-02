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
    @State private var Today = formatDate(Date().timeIntervalSince1970)
    
    //variables for displaying days will update to use Calendar instead
    @State private var selectedDayIndex = 0
    @State private var daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]

    var dayShortForm: Substring {
        let startIndex = Today.index(Today.startIndex, offsetBy: 0)
        let endIndex = Today.index(Today.startIndex, offsetBy: 3)
        return Today[startIndex..<endIndex]
    }
    @State private var viewIsShowing = false
    
    var body: some View {
        VStack(spacing: 24){
            UserGreetingView(username: $userName)//will need to pulll this from authentication
                .foregroundColor(.black)
            
            Text("\(Text("Today").font(Font.custom("Avenir", size: 18)).fontWeight(.heavy)), \n \(Today)")
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .foregroundColor(.black)
            
            
//            HStack(spacing: 15) {
//                ForEach(0..<daysOfWeek.count, id: \.self) { index in
//                    DayButtonView(selectedDay: $selectedDayIndex, dayName: daysOfWeek[index], currentDayName: String(dayShortForm), daysOfWeek: daysOfWeek)
//                }
//            }//Hstack

            CheckUpButtonView(viewIsShowing: $viewIsShowing)//Button to start Daily journal
            
            QuoteCardView()

        }//Vstack
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal)
        .background(.white)
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
                .weight(.black)
            )
            .foregroundStyle(Colors.BLACK)
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
                self.viewIsShowing.toggle()
            }
        } label:{
            VStack {
                HStack {
                    Image(systemName: "face.smiling")
                    Text("Daily Journal")
                }
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.vertical, 8)
                
                Text("How Are you feeling today?")
                    .font(.callout)
                    .tint(.purple.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 33)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 2)
            .tint(.black)
            .fullScreenCover(isPresented: $viewIsShowing, content: EmotionView.init)
        }
    }
}


//code that first started preview error?, could be that i am force unwrapping variables but when i comment this code out the issue still is happening
//struct DayButtonView: View {
//    @Binding var selectedDay: Int
//    let dayName: String
//    let currentDayName: String
//    let daysOfWeek: [String]
//    let Today = formatDate(Date().timeIntervalSince1970)
//    
//    var body: some View {
//        let isCurrentDay = dayName == currentDayName
//        let isFutureDay = !isCurrentDay && daysOfWeek.firstIndex(of: dayName)! > daysOfWeek.firstIndex(of: currentDayName)!
//        let dayNumber = calculateDayNumber(for: dayName)
//        
//        VStack{
//            Text(dayName)
//            Text(dayNumber)
//                .font(.title3)
//                .bold()
//        }//vstack
//        .padding(.vertical, 12)
//        .padding(.horizontal, 8)
//        .foregroundStyle(
//            isCurrentDay ? .purple : (isFutureDay ? .gray : .black)
//        )
//        .background(.white)
//        .clipShape(.rect(cornerRadius: 12))
//        .shadow(color: isCurrentDay ? .black.opacity(0.15): .clear, radius: 6, x: 0, y: 2)
//    }
//    
//    //gets the correct numbers for each day
//    func calculateDayNumber(for dayName: String) -> String {
//            guard let currentDayIndex = daysOfWeek.firstIndex(of: currentDayName),
//                  let dayIndex = daysOfWeek.firstIndex(of: dayName) else {
//                return ""
//            }
//            let dayDifference = dayIndex - currentDayIndex
//            let currentDayNumber = Int(Today.suffix(2)) ?? 0 // Extract the last two characters from the Today string
//            
//            let dayNumber = currentDayNumber + dayDifference
//            
//            return String(format: "%02d", max(1, dayNumber)) // Ensure the day number is at least 1
//        }
//}
