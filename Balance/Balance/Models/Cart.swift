//
//  CartModel.swift
//  Balance
//
//  Created by Yanika Telus on 11/8/23.
//

import Foundation
import SwiftData

/**
 Represents an item in a shopping cart.

 The `Cart` class represents an item that can be added to a shopping cart. It includes properties such as `id`, `aisle`, `image`, `name`, `amount`, and `unit` to describe the item.

 - Note: This class is marked as `@Model` using SwiftData, indicating it's suitable for modeling and storing data.

 - Parameters:
   - id: The unique identifier of the item.
   - aisle: The aisle or section where the item is located in the store.
   - image: The filename or path to the image representing the item.
   - name: The name or description of the item.
   - amount: The quantity or amount of the item.
   - unit: The unit of measurement for the item's quantity (e.g., "pieces," "pounds," "liters").

 - Author: Yanika Telus
 */

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
