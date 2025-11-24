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
    
    // MARK: - Steps
        func fetchStepCount(from startDate: Date,
                            to endDate: Date,
                            completion: @escaping (Double) -> Void) {
            let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            let query = HKStatisticsQuery(
                quantityType: stepType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, _ in
                let stepCount = result?.sumQuantity()?.doubleValue(for: .count()) ?? 0
                DispatchQueue.main.async {
                    completion(stepCount)
                }
            }

            healthStore.execute(query)
        }

        // MARK: - Active Energy
        func fetchActiveEnergyBurned(from startDate: Date,
                                     to endDate: Date,
                                     completion: @escaping (Double) -> Void) {
            let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            let query = HKStatisticsQuery(
                quantityType: calorieType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, _ in
                let calories = result?.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
                DispatchQueue.main.async {
                    completion(calories)
                }
            }

            healthStore.execute(query)
        }

        // MARK: - Average Heart Rate
        func fetchAverageHeartRate(from startDate: Date,
                                   to endDate: Date,
                                   completion: @escaping (Double) -> Void) {
            let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            let query = HKStatisticsQuery(
                quantityType: heartRateType,
                quantitySamplePredicate: predicate,
                options: .discreteAverage
            ) { _, result, _ in
                let unit = HKUnit.count().unitDivided(by: .minute())
                let avgHR = result?.averageQuantity()?.doubleValue(for: unit) ?? 0
                DispatchQueue.main.async {
                    completion(avgHR)
                }
            }

            healthStore.execute(query)
        }

        // MARK: - Exercise Time
        func fetchExerciseTime(from startDate: Date,
                               to endDate: Date,
                               completion: @escaping (Double) -> Void) {
            guard let exerciseType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) else {
                completion(0)
                return
            }
            
            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )
            
            let query = HKStatisticsQuery(
                quantityType: exerciseType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, result, _ in
                let minutes = result?.sumQuantity()?.doubleValue(for: .minute()) ?? 0
                DispatchQueue.main.async {
                    completion(minutes)
                }
            }
            
            healthStore.execute(query)
        }
}
