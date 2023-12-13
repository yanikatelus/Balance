//
//  Health.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//
//https://www.youtube.com/watch?v=7vOF1kGnsmo&t=418s&ab_channel=JasonDubon
import Foundation
import HealthKit


struct HeartRateDataPoint: Hashable{
    let timestamp: Date
    let bpm: Double
}

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

/**
 Manages health-related data and interactions with HealthKit.

 The `HealthManager` class provides functionality for managing health-related data and interacting with HealthKit. It tracks and updates data such as steps, calories burned, and heart rate data.

 - Author: Yanika Telus
 */
class HealthManager: ObservableObject {
    var heartRateDataArray: [HeartRateDataPoint] = []
    
    let healthStore = HKHealthStore()
    
    @Published var todaySteps: String = "0"
    @Published var todayCaloriesBurned: Int = 0
    @Published var todaytotalCaloriesBurned: Int = 0
    
    /**
     Initializes an instance of the HealthManager class and requests HealthKit authorization.

     The initializer requests authorization to access health data types like steps, calorie burned, basal calorie burned, and heart rate data from HealthKit.

     */
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
    
    /**
     Fetches today's step count data and updates the `todaySteps` property.

     This method fetches the user's step count data for the current day and updates the `todaySteps` property with the retrieved data.

     */
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
    
    /**
     Fetches today's calorie burned data and updates the `todayCaloriesBurned` property.

     This method fetches the user's calorie burned data for the current day and updates the `todayCaloriesBurned` property with the retrieved data.

     */
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
    
    /**
     Fetches today's total calorie burned data and updates the `todaytotalCaloriesBurned` property.

     This method fetches the user's total calorie burned data, including active and basal calories, for the current day and updates the `todaytotalCaloriesBurned` property with the retrieved data.

     */
    func fetchTodayTotalCaloriesBurned() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
        
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate) { _, activeCalorieResult, error in
            guard let activeQuantity = activeCalorieResult?.sumQuantity(), error == nil else {
                print("error fetching today's Active Calorie data")
                return
            }
            
            let basalPredicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: .startOfDay), end: Date())
            let basalQuery = HKStatisticsQuery(quantityType: basalCalorieType, quantitySamplePredicate: basalPredicate) { _, basalCalorieResult, basalError in
                guard let basalQuantity = basalCalorieResult?.sumQuantity(), basalError == nil else {
                    print("error fetching today's Basal Calorie data")
                    return
                }
                
                let totalCalories = activeQuantity.doubleValue(for: .largeCalorie()) + basalQuantity.doubleValue(for: .largeCalorie())
                
                DispatchQueue.main.async {
                    self.todaytotalCaloriesBurned = Int(totalCalories)
                }
            }
            
            self.healthStore.execute(basalQuery)
        }//active calorie query

        healthStore.execute(query)
    }
    
//    func fetchHeartRateData() {
//        // Define the heart rate type
//        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
//
//        // Create a predicate for the last 24 hours
//        let predicate = HKQuery.predicateForSamples(withStart: Date().addingTimeInterval(-24 * 3600), end: Date(), options: .strictStartDate)
//
//        // Create a query to fetch heart rate data
//        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
//            guard let result = result, error == nil else {
//                print("Error fetching heart rate data: \(error?.localizedDescription ?? "")")
//                return
//            }
//
//            if let averageBPM = result.averageQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) {
//                // Handle the averageBPM data point here
//                print("Average Heart Rate: \(averageBPM) BPM")
//
//                // You can add this data point to your heart rate data array
//                let timestamp = Date()// Use the current timestamp
//                let heartRateDataPoint = HeartRateDataPoint(timestamp: timestamp, bpm: averageBPM)
//
//                // Add the heartRateDataPoint to your data array
//                self.heartRateDataArray.append(heartRateDataPoint)
//            }
//        }
//
//        // Execute the query
//        self.healthStore.execute(query)
//    }
    
    /**
         Fetches historical heart rate data and updates the `heartRateDataArray` property.

         This method fetches historical heart rate data from HealthKit for the past 8 hours and updates the `heartRateDataArray` property with the retrieved data.

         */
    func fetchHistoricalHeartRateData() {
        let healthStore = HKHealthStore()
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        // Calculate the start date for the past 8 hours
        let eightHoursAgo = Calendar.current.date(byAdding: .hour, value: -8, to: Date())!

        let predicate = HKQuery.predicateForSamples(withStart: eightHoursAgo, end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, results, error in
            guard let results = results as? [HKQuantitySample], error == nil else {
                print("Error fetching historical heart rate data: \(error?.localizedDescription ?? "")")
                return
            }

            // Process the fetched heart rate data
            let heartRateData = results.map { sample in
                HeartRateDataPoint(timestamp: sample.startDate, bpm: sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
            }

            // Update your data array with the historical heart rate data
            self.heartRateDataArray = heartRateData
        }

        healthStore.execute(query)
    }
}
/**
     Converts a Double value into a formatted String.

     This method takes a Double value and converts it into a formatted String with no decimal places using `NumberFormatter`.

     - Returns: A formatted String representation of the Double value.
     */
extension Double {
    func formattedString() -> String? {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        numberFormater.maximumFractionDigits = 0
        
        return numberFormater.string(from: NSNumber(value: self))
    }
}
