//
//  Health.swift
//  Balance
//
//  Created by Yanika Telus on 12/12/23.
//

import Foundation
import HealthKit

@Observable
class HealthMannager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task {
            do{
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            }catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
}
