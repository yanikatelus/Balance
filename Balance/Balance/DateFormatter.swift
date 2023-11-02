//
//  DateFormatter.swift
//  Balance
//
//  Created by Yanika Telus on 10/21/23.
//

import Foundation


func formatDateNote(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMMM d"
    return formatter.string(from: date)
}


func formatDate(_ timeStamp: Double) -> String {
    let epocTime = TimeInterval(timeStamp)
    let myDate = Date(timeIntervalSince1970: epocTime)
    
    let components = Calendar.current.dateComponents([.hour, .minute,.weekday, .day, .month, .year], from: myDate)
    let weekdayNum = components.weekday ?? 0
    var weekday = ""
    switch weekdayNum{
        case 1:
            weekday = "Sunday"
        case 2:
            weekday = "Monday"
        case 3:
            weekday = "Tuesday"
        case 4:
            weekday = "Wednesday"
        case 5:
            weekday = "Thursday"
        case 6:
            weekday = "Friday"
        default :
            weekday = "Saturday"
    }
    let day = components.day ?? 0
//    let month = components.month ?? 0
    let month = getMonth(month: components)
//    let year = components.year ?? 0
    //would it be better to break up year>
    return "\(weekday) \(month) \(day)"
    //"Sun 12 20"
}

func getMonth(month: DateComponents) -> String{
   let monthNum =  month.month ?? 0
    var monthString = ""
    switch monthNum{
        case 1:
            monthString = "January"
        case 2:
            monthString = "February"
        case 3:
            monthString = "March"
        case 4:
            monthString = "April"
        case 5:
            monthString = "May"
        case 6:
            monthString = "June"
        case 7:
            monthString = "July"
        case 8:
            monthString = "August"
        case 9:
            monthString = "September"
        case 10:
            monthString = "October"
        case 11:
            monthString = "November"
        default:
            monthString = "December"
    }
    return monthString
}
