//
//  Activity.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//

/**
 Represents an activity with step and calorie goals.

 The `Activity` class represents an activity with associated step and calorie goals. It is used to store and manage activity-related information.

 - Author: Yanika Telus
 */

import Foundation
import SwiftData

@Model
final class Activity{
    var stepGoal: Int
    var calorieGoal: Int
    
    init(stepGoal: Int, calorieGoal: Int) {
        self.stepGoal = stepGoal
        self.calorieGoal = calorieGoal

    }
}
