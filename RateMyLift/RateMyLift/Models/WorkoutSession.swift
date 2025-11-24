//
//  WorkoutSession.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import Foundation
import Combine

final class WorkoutSession: ObservableObject {
    @Published var name: String = "New Workout"
    
    @Published var startDate: Date?
    @Published var endDate: Date?
    
    @Published var steps: Double = 0
    @Published var calories: Double = 0
    @Published var avgHR: Double = 0
    @Published var exerciseMinutes: Double = 0
    
    // Timer
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // Hold exercises you build in DuringWorkout / AddExerciseView
    @Published var exercises: [Exercise] = []
    
    func reset() {
        name = "New Workout"
        startDate = nil
        endDate = nil
        steps = 0
        calories = 0
        avgHR = 0
        exerciseMinutes = 0
        hours = 0
        minutes = 0
        seconds = 0
        exercises = []
    }
}
