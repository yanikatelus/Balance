//
//  JournalDataModel.swift
//  Balance
//
//  Created by Yanika Telus on 10/22/23.
//

import Foundation
import SwiftData

/*
 Swiftdata Model
 @Model - Converts a Swift class into a stored model that’s managed by SwiftData
 */

@Model
final class Notes {
    var timestamp: String
    var title: String
    var content: String
    var emoticon: String
    var activities: [String]
    
    init(timestamp: String, title: String, content: String, emoticon: String, activities: [String]) {
        self.timestamp = timestamp
        self.title = title
        self.content = content
        self.emoticon = emoticon
        self.activities = activities
    }
}
