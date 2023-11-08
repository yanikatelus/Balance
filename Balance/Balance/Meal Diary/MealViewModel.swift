//
//  MealViewModel.swift
//  Balance
//
//  Created by Yanika Telus on 11/7/23.
//

import Foundation

// ingredient model
struct Ingredient: Codable, Identifiable, Hashable {
    var id: Int
    var aisle: String
    var image: String
    var name: String
    var amount: Double
    var unit: String
}

//recipe model
struct Recipe: Codable, Identifiable, Hashable {
    var id: Int
    var aggregateLikes: Int
    var title: String
    var readyInMinutes: Int
    var servings: Int
    var image: String
    var summary: String
    var instructions: String
    var healthScore: Int
    var extendedIngredients: [Ingredient]
}

// response model
struct RecipeResponse: Codable, Hashable {
    var recipes: [Recipe]
}

// Mock data based on the provided output in Rapid API
let mockRecipes: [Recipe] = [
    Recipe(
        id: 641168,
        aggregateLikes:4,
        title: "Cyndee's Neiman Marcus Cake",
        readyInMinutes: 45,
        servings: 12,
        image: "https://spoonacular.com/recipeImages/641168-556x370.jpg",
        summary: "A delightful cake...",
        instructions: "Preheat oven to 350.Mix 1 cup sugar and butter together in a medium mixing bowl. Add in eggs.Add in 1 tbsp of the lemon water, mix well.Add milk, mix well.Add in salt, flour, and baking powder, mix well.Pour into a round 8\" baking pan.Place in oven and bake for 30 minutes, or until you get a clean toothpick from the center.Allow to cool slightly.Mix  cup lemon water and  cup sugar. Drizzle over the top of the cake, and then sprinkle the top with powdered sugar.", 
        healthScore: 28,
        extendedIngredients: [
            Ingredient(
                id: 18372,
                aisle: "Baking",
                image: "white-powder.jpg",
                name: "baking soda",
                amount: 0.75,
                unit: "teaspoon"
            ),
            Ingredient(
                id: 1001,
                aisle: "Milk, Eggs, Other Dairy",
                image: "butter-sliced.jpg",
                name: "butter",
                amount: 3,
                unit: "ounces"
            ),
            Ingredient(
                id: 19335,
                aisle: "Baking",
                image: "sugar-in-bowl.png",
                name: "sugar",
                amount: 4,
                unit: "ounces"
            )
            // Add more ingredients as needed
        ]
    ),
    Recipe(
        id: 641160,
        aggregateLikes:2,
        title: "Cyndee's Neiman Marcus Cake",
        readyInMinutes: 70,
        servings: 2,
        image: "https://spoonacular.com/recipeImages/715395-556x370.jpg",
        summary: "Cyndee's Neiman Marcus Cake requires about <b>45 minutes</b> from start to finish. For <b>67 cents per serving</b>, this recipe <b>covers 6%</b> of your daily requirements of vitamins and minerals. This dessert has <b>304 calories</b>, <b>5g of protein</b>, and <b>21g of fat</b> per serving. This recipe serves 12. 4 people found this recipe to be tasty and satisfying. It is brought to you by Foodista. It is a good option if you're following a <b>lacto ovo vegetarian</b> diet. If you have lemon zest, vanillan extract, cornstarch, and a few other ingredients on hand, you can make it. Taking all factors into account, this recipe <b>earns a spoonacular score of 21%</b>, which is not so awesome. Similar recipes include",
        instructions:"Preheat oven to 350.Mix 1 cup sugar and butter together in a medium mixing bowl. Add in eggs.Add in 1 tbsp of the lemon water, mix well.Add milk, mix well.Add in salt, flour, and baking powder, mix well.Pour into a round 8 inch baking pan.Place in oven and bake for 30 minutes, or until you get a clean toothpick from the center.Allow to cool slightly.Mix cup lemon water and cup sugar. Drizzle over the top of the cake, and then sprinkle the top with powdered sugar.", 
        healthScore: 57,
        extendedIngredients: [
            Ingredient(
                id:18369,
                aisle:"Baking",
                image:"white-powder.jpg",
                name:"baking powder",
                amount:1,
                unit:"tsp"
            ),
            Ingredient(
                id:1123,
                aisle:"Milk, Eggs, Other Dairy",
                image:"egg.png",
                name:"eggs",
                amount:2,
                unit:""
            ),
            Ingredient(
                id:20081,
                aisle:"Baking",
                image:"flour.png",
                name:"flour",
                amount:1.5,
                unit:"cups"
            ),
            Ingredient(
                id:1077,
                aisle:"Milk, Eggs, Other Dairy",
                image:"milk.png",
                name:"milk",
                amount:0.5,
                unit:"cup"
            ),
            Ingredient(
                id:19336,
                aisle:"Baking",
                image:"powdered-sugar.jpg",
                name:"powdered sugar",
                amount:0.5,
                unit:"cup"
            )
            // Add more ingredients
        ]
    ),
    
    Recipe(
        id: 641166,
        aggregateLikes:2,
        title: "Cyndee's Neiman Marcus Cake",
        readyInMinutes: 70,
        servings: 2,
        image: "https://spoonacular.com/recipeImages/915395-556x370.jpg",
        summary: "Cyndee's Neiman Marcus other food requires about <b>45 minutes</b> from start to finish. For <b>67 cents per serving</b>, this recipe <b>covers 6%</b> of your daily requirements of vitamins and minerals. This dessert has <b>304 calories</b>, <b>5g of protein</b>, and <b>21g of fat</b> per serving. This recipe serves 12. 4 people found this recipe to be tasty and satisfying. It is brought to you by Foodista. It is a good option if you're following a <b>lacto ovo vegetarian</b> diet. If you have lemon zest, vanillan extract, cornstarch, and a few other ingredients on hand, you can make it. Taking all factors into account, this recipe <b>earns a spoonacular score of 21%</b>, which is not so awesome. Similar recipes include",
        instructions:"Preheat oven to 350.Mix 1 cup sugar and butter together in a medium mixing bowl. Add in eggs.Add in 1 tbsp of the lemon water, mix well.Add milk, mix well.Add in salt, flour, and baking powder, mix well.Pour into a round 8 inch baking pan.Place in oven and bake for 30 minutes, or until you get a clean toothpick from the center.Allow to cool slightly.Mix cup lemon water and cup sugar. Drizzle over the top of the cake, and then sprinkle the top with powdered sugar.", 
        healthScore: 82,
        extendedIngredients: [
            Ingredient(
                id:18369,
                aisle:"Baking",
                image:"white-powder.jpg",
                name:"baking powder",
                amount:1,
                unit:"tsp"
            ),
            Ingredient(
                id:1123,
                aisle:"Milk, Eggs, Other Dairy",
                image:"egg.png",
                name:"eggs",
                amount:2,
                unit:""
            ),
            Ingredient(
                id:20081,
                aisle:"Baking",
                image:"flour.png",
                name:"flour",
                amount:1.5,
                unit:"cups"
            ),
            Ingredient(
                id:1077,
                aisle:"Milk, Eggs, Other Dairy",
                image:"milk.png",
                name:"milk",
                amount:0.5,
                unit:"cup"
            ),
            Ingredient(
                id:19336,
                aisle:"Baking",
                image:"powdered-sugar.jpg",
                name:"powdered sugar",
                amount:0.5,
                unit:"cup"
            )
            // Add more ingredients
        ]
    ),
    Recipe(
        id: 743166,
        aggregateLikes:2,
        title: "Homemade toast",
        readyInMinutes: 70,
        servings: 2,
        image: "https://spoonacular.com/recipeImages/725395-556x370.jpg",
        summary: "Cyndee's Neiman Marcus other food requires about <b>45 minutes</b> from start to finish. For <b>67 cents per serving</b>, this recipe <b>covers 6%</b> of your daily requirements of vitamins and minerals. This dessert has <b>304 calories</b>, <b>5g of protein</b>, and <b>21g of fat</b> per serving. This recipe serves 12. 4 people found this recipe to be tasty and satisfying. It is brought to you by Foodista. It is a good option if you're following a <b>lacto ovo vegetarian</b> diet. If you have lemon zest, vanillan extract, cornstarch, and a few other ingredients on hand, you can make it. Taking all factors into account, this recipe <b>earns a spoonacular score of 21%</b>, which is not so awesome. Similar recipes include",
        instructions:"Preheat oven to 350.Mix 1 cup sugar and butter together in a medium mixing bowl. Add in eggs.Add in 1 tbsp of the lemon water, mix well.Add milk, mix well.Add in salt, flour, and baking powder, mix well.Pour into a round 8 inch baking pan.Place in oven and bake for 30 minutes, or until you get a clean toothpick from the center.Allow to cool slightly.Mix cup lemon water and cup sugar. Drizzle over the top of the cake, and then sprinkle the top with powdered sugar.", 
        healthScore: 49,
        extendedIngredients: [
            Ingredient(
                id:18369,
                aisle:"Baking",
                image:"white-powder.jpg",
                name:"baking powder",
                amount:1,
                unit:"tsp"
            ),
            Ingredient(
                id:1123,
                aisle:"Milk, Eggs, Other Dairy",
                image:"egg.png",
                name:"eggs",
                amount:2,
                unit:""
            ),
            Ingredient(
                id:20081,
                aisle:"Baking",
                image:"flour.png",
                name:"flour",
                amount:1.5,
                unit:"cups"
            ),
            Ingredient(
                id:1077,
                aisle:"Milk, Eggs, Other Dairy",
                image:"milk.png",
                name:"milk",
                amount:0.5,
                unit:"cup"
            ),
            Ingredient(
                id:19336,
                aisle:"Baking",
                image:"powdered-sugar.jpg",
                name:"powdered sugar",
                amount:0.5,
                unit:"cup"
            )
            // Add more ingredients
        ]
    )
    // Add more recipes
]
