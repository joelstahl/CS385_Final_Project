//
//  WorkoutData.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import Foundation
import SwiftData

@Model
final class Workout {
    var name: String
    var start: Date
    var end: Date?
    var totalcalories: Double
    var avgHeartRate: Double
    var exercises: [Exercise]
    
    init(name: String, start: Date, end: Date? = nil, totalcalories: Double, avgHeartRate: Double, exercises: [Exercise] = []) {
        self.name = name
        self.exercises = exercises
        self.start = start
        self.end = end
        self.totalcalories = totalcalories
        self.avgHeartRate = avgHeartRate
    }
    
    init() {
        self.name = "Push Day"
        self.exercises = [Exercise()]
        self.start = Date()
        self.end = nil
        self.totalcalories = 543.9
        self.avgHeartRate = 88.0
    }
}

@Model
final class Exercise {
    var name: String
    var sets: [Sets] //Have to name sets instead of set to not mess up the healthStore
    
    init(name: String, sets: [Sets] = []) {
        self.name = name
        self.sets = sets
    }
    
    init(){
        self.name = "Bench Press"
        self.sets = [Sets()]
    }
}

@Model
final class Sets {
    var weight: Int
    var reps: Int
    
    init(weight: Int, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
    
    init(){
        self.weight = 225
        self.reps = 8
    }
}
