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
    var id: Int
    var aisle: String
    var image: String
    var name: String
    var amount: Double
    var unit: String
    
    init(id: Int, aisle: String, image: String, name: String, amount: Double, unit: String) {
        self.id = id
        self.aisle = aisle
        self.image = image
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}
