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
    //Integrate with Forestore. save UID of current logged in user
//    var userId: String
    var timestamp: String
    var title: String
    var content: String
    var emoticon: String
    var activities: [String]
    
//    init(userId: String, timestamp: String, title: String, content: String, emoticon: String, activities: [String]) {
//        self.userId = userId
    init(timestamp: String, title: String, content: String, emoticon: String, activities: [String]) {
        self.timestamp = timestamp
        self.title = title
        self.content = content
        self.emoticon = emoticon
        self.activities = activities
    }
}
