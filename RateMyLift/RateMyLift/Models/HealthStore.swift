//
//  HealthStore.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/17/25.
//

import HealthKit

class HealthKitManager {
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        // Define the types of data your app needs to read and/or write
        let healthDataToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!, //Steps
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!, //Calories
            HKObjectType.quantityType(forIdentifier: .heartRate)!, //Heartrate
            //HKObjectType.workoutType(), //Workout Type?
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
        ]

        let healthDataToWrite: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .bodyMass)!
        ]

        healthStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead) { (success, error) in
            completion(success, error)
        }
    }
    
    //Fetch StepCountData
    func fetchStepCount(completion: @escaping (Double) -> Void){
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startDate = Calendar.current.startOfDay(for: Date()) //Todays Date
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum){
            _, result, _ in
            
            let stepCount = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
            
            DispatchQueue.main.async {
                completion(stepCount)
            }
        }
        healthStore.execute(query)
    }
    
    //Calories
    func fetchActiveEnergyBurned(completion: @escaping (Double) -> Void){
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let startDate = Calendar.current.startOfDay(for: Date()) //Todays Date
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum){
            _, result, _ in
            
            let calorieCount = result?.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0 //Calories type is in kilocalorie
            
            DispatchQueue.main.async {
                completion(calorieCount)
            }
        }
        healthStore.execute(query)
    }
    
    //Fetch Heart rate because its an average
    func fetchAverageHeartRateToday(completion: @escaping (Double) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let startDate = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) {
            _, result, _ in
            
            let unit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let avgHR = result?.averageQuantity()?.doubleValue(for: unit) ?? 0
            
            DispatchQueue.main.async {
                completion(avgHR)
            }
        }
        
        healthStore.execute(query)
    }
    
    //Exercise Time
    func fetchExerciseTimeToday(completion: @escaping (Double) -> Void) {
        guard let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else {
            completion(0)
            return
        }
        
        let startDate = Calendar.current.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: exerciseType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            _, result, _ in
            
            let minutes = result?.sumQuantity()?.doubleValue(for: HKUnit.minute()) ?? 0
            
            DispatchQueue.main.async {
                completion(minutes)
            }
        }
        
        healthStore.execute(query)
    }
    
}
