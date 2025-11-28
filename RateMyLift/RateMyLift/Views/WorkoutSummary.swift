//
//  WorkoutSummary.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI
import SwiftData

struct WorkoutSummary: View {
    @EnvironmentObject var session: WorkoutSession
    @Environment(\.modelContext) private var modelContext
    
    // Get the currently active user
    @Query(filter: #Predicate<User> { $0.active == true })
    private var activeUsers: [User]
    
    @State private var saveMessage: String?

    var body: some View {
        VStack(spacing: 16) {
            Text("Workout Summary")
                .font(.largeTitle.bold())
            
            // Allow user to name the workout
            TextField("Workout name", text: $session.name)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            if let start = session.startDate,
               let end = session.endDate {
                Text("Start: \(start.formatted(date: .omitted, time: .standard))")
                Text("End: \(end.formatted(date: .omitted, time: .standard))")
            }
            
            Text(String(format: "Duration: %02d:%02d:%02d",
                        session.hours,
                        session.minutes,
                        session.seconds))
                .font(.title2.monospacedDigit())
                .padding(.top)
            
            Divider()
            
            Text("Steps: \(Int(session.steps))")
            Text("Calories: \(Int(session.calories)) kcal")
            Text("Avg HR: \(Int(session.avgHR)) bpm")
            Text("Exercise Time: \(Int(session.exerciseMinutes)) min")
            
            Divider()
            
            Button("Save Workout") {
                saveWorkout()
            }
            .buttonStyle(.borderedProminent)
            
            if let msg = saveMessage {
                Text(msg)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func saveWorkout() {
        guard let user = activeUsers.first else {
            saveMessage = "No active user found."
            return
        }
        
        guard let start = session.startDate else {
            saveMessage = "Missing start time."
            return
        }
        
        // Build the Workout model from the session
        let workout = Workout(
            name: session.name.isEmpty ? "Workout" : session.name,
            start: start,
            end: session.endDate,
            totalcalories: session.calories,
            avgHeartRate: session.avgHR,
            exercises: session.exercises // already [Exercise]
        )
        
        // Attach to the user
        user.workouts.append(workout)
        
        do {
            try modelContext.save()
            saveMessage = "Workout saved!"
        } catch {
            saveMessage = "Failed to save workout: \(error.localizedDescription)"
        }
    }
}

#Preview {
    WorkoutSummary()
        .environmentObject(WorkoutSession())
}

