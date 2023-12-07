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

