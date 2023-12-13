//
//  Health.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//
//https://www.youtube.com/watch?v=7vOF1kGnsmo&t=418s&ab_channel=JasonDubon
import Foundation
import HealthKit

struct HeartRateDataPoint {
    let timestamp: Date
    let bpm: Double
}

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    var heartRateDataArray: [HeartRateDataPoint] = []
    
    let healthStore = HKHealthStore()
    
    @Published var todaySteps: String = "0"
    @Published var todayCaloriesBurned: Int = 0
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calorieBurned = HKQuantityType(.activeEnergyBurned)
        let basalEnergyBurned = HKQuantityType(.basalEnergyBurned)
        let heartrate = HKQuantityType(.heartRate)
        let healthTypes: Set = [steps, calorieBurned, basalEnergyBurned, heartrate]
        
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
    
    func fetchHeartRateData() {
        // Define the heart rate type
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        // Create a predicate for the last 24 hours
        let predicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(-24 * 3600), end: Date(), options: .strictStartDate)

        // Create a query to fetch heart rate data
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
            guard let result = result, error == nil else {
                print("Error fetching heart rate data: \(error?.localizedDescription ?? "")")
                return
            }

            if let averageBPM = result.averageQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) {
                // Handle the averageBPM data point here
                print("Average Heart Rate: \(averageBPM) BPM")

                // You can add this data point to your heart rate data array
                let timestamp = Date() // Use the current timestamp
                let heartRateDataPoint = HeartRateDataPoint(timestamp: timestamp, bpm: averageBPM)

                // Add the heartRateDataPoint to your data array
                self.heartRateDataArray.append(heartRateDataPoint)
            }
        }

        // Execute the query
        self.healthStore.execute(query)
    }
}

extension Double {
    func formattedString() -> String? {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.maximumFractionDigits = 0
        
        return numberFormater.string(from: NSNumber(value: self))
    }
}
