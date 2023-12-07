//
//  User.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    var profileImageUrl: String? // Optional property for profile image URL
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "test@gmail.com" )
}
