//
//  DateFormatter.swift
//  Balance
//
//  Created by Yanika Telus on 10/21/23.
//

import Foundation

/**
 Formats a date into a string representation.

 This function takes a `Date` and formats it into a string representation with the format "EEEE MMMM d".

 - Parameters:
   - date: The date to be formatted.

 - Returns: A string representation of the provided date in the format "EEEE MMMM d".
 */

func formatDateNote(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMMM d"
    return formatter.string(from: date)
}

