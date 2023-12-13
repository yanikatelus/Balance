//
//  Health.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//
//https://www.youtube.com/watch?v=7vOF1kGnsmo&t=418s&ab_channel=JasonDubon
import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var todaySteps: String = "0"
    @Published var todayCaloriesBurned: Int = 0
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calorieBurned = HKQuantityType(.activeEnergyBurned)
        let basalEnergyBurned = HKQuantityType(.basalEnergyBurned)
        let healthTypes: Set = [steps, calorieBurned, basalEnergyBurned]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today's steps data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            
            DispatchQueue.main.async {
                self.todaySteps = "\(stepCount.formattedString() ?? "0")"
            }
        }
        healthStore.execute(query)
    }//Fetch todays steps
    
    func fetchTodayCaloriesBurned() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today's Calorie data")
                return
            }
            let calories = quantity.doubleValue(for: .largeCalorie())
            DispatchQueue.main.async {
                self.todayCaloriesBurned = Int(calories)
            }
        }//query
        healthStore.execute(query)
    }
//    func fetchTodayCaloriesBurned() {
//        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
//        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
//        
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
//        
//        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate) { _, activeCalorieResult, error in
//            guard let activeQuantity = activeCalorieResult?.sumQuantity(), error == nil else {
//                print("error fetching today's Active Calorie data")
//                return
//            }
//            
//            let basalPredicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
//            let basalQuery = HKStatisticsQuery(quantityType: basalCalorieType, quantitySamplePredicate: basalPredicate) { _, basalCalorieResult, basalError in
//                guard let basalQuantity = basalCalorieResult?.sumQuantity(), basalError == nil else {
//                    print("error fetching today's Basal Calorie data")
//                    return
//                }
//                
//                let totalCalories = activeQuantity.doubleValue(for: .largeCalorie()) + basalQuantity.doubleValue(for: .largeCalorie())
//                
//                DispatchQueue.main.async {
//                    self.todayCaloriesBurned = Int(totalCalories)
//                }
//            }
//            
//            self.healthStore.execute(basalQuery)
//        }//active calorie query
//
//        healthStore.execute(query)
//    }
}

extension Double {
    func formattedString() -> String? {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.maximumFractionDigits = 0
        
        return numberFormater.string(from: NSNumber(value: self))
    }
}
