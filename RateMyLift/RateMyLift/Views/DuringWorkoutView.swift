//
//  DuringWorkoutView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI
import Foundation
import HealthKit

struct DuringWorkoutView: View {
    @EnvironmentObject var session: WorkoutSession
    
    @State private var timerIsPaused: Bool = true
    @State private var timer: Timer? = nil
    @State private var showAddExerciseView: Bool = false
    @State private var showSummary: Bool = false
    
    private let healthKitManager = HealthKitManager()
    
    var body: some View {
        VStack(spacing: 24) {
            // TIMER DISPLAY
            Text(String(format: "%02d:%02d:%02d",
                        session.hours,
                        session.minutes,
                        session.seconds))
                .font(.largeTitle.monospacedDigit())
            
            // TIMER CONTROLS
            if timerIsPaused {
                HStack {
                    Button(action: {
                        restartTimer()
                    }) {
                        Image(systemName: "backward.end.alt")
                            .padding()
                    }
                    
                    Button(action: {
                        startTimer()
                    }) {
                        Image(systemName: "play.fill")
                            .padding()
                    }
                }
            } else {
                Button(action: {
                    finishWorkout()
                }) {
                    Label("End Workout", systemImage: "stop.fill")
                        .padding()
                }
            }
            
            // EXERCISES
            VStack {
                Text("Current Exercises")
                    .font(.headline)
                
                Button(action: {
                    showAddExerciseView = true
                }) {
                    Text("Add Exercise")
                }
            }
            
            // NAVIGATION TO SUMMARY
            NavigationLink(
                "Workout Summary",
                isActive: $showSummary,
                destination: {
                    WorkoutSummary()
                        .environmentObject(session)
                }
            )
            
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .padding(.vertical, 8)
        .sheet(isPresented: $showAddExerciseView) {
            AddExerciseView()
        }
        .onDisappear {
            // make sure timer is cleaned up
            stopTimerOnly()
        }
    }
    
    // MARK: - Timer
    
    func startTimer() {
        guard timer == nil else { return }
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if session.seconds == 59 {
                session.seconds = 0
                if session.minutes == 59 {
                    session.minutes = 0
                    session.hours += 1
                } else {
                    session.minutes += 1
                }
            } else {
                session.seconds += 1
            }
        }
    }
    
    func stopTimerOnly() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer() {
        session.hours = 0
        session.minutes = 0
        session.seconds = 0
    }
    
    // MARK: - Finish workout (stop + fetch stats + go to summary)
    
    func finishWorkout() {
        stopTimerOnly()
        
        session.endDate = Date()
        
        guard let start = session.startDate,
              let end = session.endDate else {
            return
        }
        
        // Fetch health data for the session
        healthKitManager.fetchStepCount(from: start, to: end) { value in
            DispatchQueue.main.async {
                self.session.steps = value
            }
        }
        
        healthKitManager.fetchActiveEnergyBurned(from: start, to: end) { value in
            DispatchQueue.main.async {
                self.session.calories = value
            }
        }
        
        healthKitManager.fetchAverageHeartRate(from: start, to: end) { value in
            DispatchQueue.main.async {
                self.session.avgHR = value
            }
        }
        
        healthKitManager.fetchExerciseTime(from: start, to: end) { value in
            DispatchQueue.main.async {
                self.session.exerciseMinutes = value
            }
        }
        
        // Navigate to summary
        showSummary = true
    }
}

#Preview {
    DuringWorkoutView()
        .environmentObject(WorkoutSession())
}

