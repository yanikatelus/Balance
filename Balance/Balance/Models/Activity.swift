//
//  Activity.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//

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
