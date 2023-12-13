//
//  User.swift
//  Balance
//
//  Created by Yanika Telus on 11/16/23.
//
/**
 Represents a user in the application.

 The `User` struct represents a user with properties such as `id`, `fullname`, `email`, and an optional `profileImageUrl` to describe a user's profile information.

 - Parameters:
   - id: The unique identifier of the user.
   - fullname: The full name of the user.
   - email: The email address associated with the user.
   - profileImageUrl: An optional URL pointing to the user's profile image.
 */
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
