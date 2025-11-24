//
//  AddPost.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/17/25.
//

import SwiftUI
import HealthKit

import SwiftUI
import HealthKit

struct StartWorkout: View {
    @StateObject private var session = WorkoutSession()
    @State private var showDuringWorkout = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Start Workout") {
                    session.reset()
                    session.startDate = Date()
                    showDuringWorkout = true
                }
                .buttonStyle(.borderedProminent).tint(.red)
                
                // If you want, you can show last workout stats here later
                // using session.steps, session.calories, etc.
                
                NavigationLink(
                    "",
                    isActive: $showDuringWorkout,
                    destination: {
                        DuringWorkoutView()
                            .environmentObject(session)
                    }
                )
                .hidden()
            }
            .padding()
        }
    }
}

#Preview {
    StartWorkout()
}



#Preview {
    StartWorkout()
}
