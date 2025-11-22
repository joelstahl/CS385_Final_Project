//
//  RateMyLiftApp.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

@main
struct RateMyLiftApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Post.self,
            Comment.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
