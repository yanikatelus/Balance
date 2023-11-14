//
//  MealAPIModel.swift
//  Balance
//
//  Created by Yanika Telus on 11/7/23.
//

import Foundation

class RecipeAPI {
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/random?apiKey=YOUR_API_KEY&number=10"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1002, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                completion(.success(recipeResponse.recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
