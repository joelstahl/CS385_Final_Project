//
//  PostWorkout.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/17/25.
//

import SwiftUI

struct PostWorkout: View {
    @State var workouts: [Workout]
    
    var postWorkoutSheet: Bool = false
    
    var body: some View {
        
        NavigationStack{
            Text("Choose a workout to post").font(.headline).italic()
            List{
                ForEach(workouts){ workout in
                    NavigationLink(destination: PostingWorkoutView(workout: workout)){
                        Text(workout.name + " \(workout.start.formatted(date: .omitted, time: .standard))")
                    }
                }
            }
            .navigationTitle(Text("Workouts"))
        }
    }
}

#Preview {
    PostWorkout(workouts: [Workout(), Workout(), Workout(),])
}
