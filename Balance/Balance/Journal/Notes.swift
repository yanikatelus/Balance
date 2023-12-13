//
//  JournalDataModel.swift
//  Balance
//
//  Created by Yanika Telus on 10/22/23.
//

import Foundation
import SwiftData

/**
 Represents a journal entry.

 The `Notes` class represents a journal entry in the application. It includes properties such as `timestamp`, `title`, `content`, `emoticon`, and `activities` to describe the journal entry.

 - Note: This class is marked as `@Model` using SwiftData, indicating it's suitable for modeling and storing data.

 - Parameters:
   - timestamp: The timestamp when the journal entry was created.
   - title: The title of the journal entry.
   - content: The content or text of the journal entry.
   - emoticon: The emoticon associated with the journal entry.
   - activities: An array of activity names related to the journal entry.

 */

@Model
final class Notes {
    //Integrate with Forestore. save UID of current logged in user // running into issues itegrating will hold off
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
