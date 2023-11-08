//
//  CartModel.swift
//  Balance
//
//  Created by Yanika Telus on 11/8/23.
//

import Foundation
import SwiftData

@Model
final class Cart{
    
    var ingredientList: [Ingredient]
    
    init(ingredientList: [Ingredient]) {
        self.ingredientList = ingredientList
    }
}
