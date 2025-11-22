//
//  AddPost.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/17/25.
//

import SwiftUI
import HealthKit

struct StartWorkout: View {
    @State private var stepCount: Double = 0
    let healthKitManager = HealthKitManager()
    
    var body: some View {
//        VStack {
//            Text("Today's Steps").font(.title)
//            Text("\(Int(stepCount))").bold().font(.largeTitle)
//            
//            Button("Fetch Steps") {
//                healthKitManager.fetchStepCount { steps in
//                    stepCount = steps
//                }
//            }
//        }
//        .buttonStyle(.borderedProminent)
//        .tint(.green)
//        .onAppear {
//            requestHealthKitAccess()
//        }
//    }
//    
//    func requestHealthKitAccess() {
//        healthKitManager.requestAuthorization { success, error in
//            if let error = error {
//                print("HealthKit auth failed: \(error.localizedDescription)")
//            } else {
//                print("HealthKit auth was successful: \(success)")
//            }
//        }
    }
}


#Preview {
    StartWorkout()
}
