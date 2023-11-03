//
//  RadioOptions.swift
//  Balance
//
//  Created by Yanika Telus on 11/2/23.
//

import Foundation

/**
 Represents the various emoticon choices available for the user to select.

 Each case corresponds to a unique emoticon with a distinct `imageName`. This enum provides a strongly-typed
 and structured way to handle and represent emoticon selections in the application.
 
 - Note: Ensure that each `imageName` corresponds to a valid asset in the project.
 
 - Author: Yanika
*/
enum RadioOption: Int, CaseIterable, Identifiable, Codable {
    case option1, option2, option3, option4, option5

    var id: Int { rawValue }

    var imageName: String {
        switch self {
            case .option1:
                return "depressed"
            case .option2:
                return "sad"
            case .option3:
                return "Indifferent"
            case .option4:
                return "happy"
            case .option5:
                return "estatic"
        }
    }
}//Enum
