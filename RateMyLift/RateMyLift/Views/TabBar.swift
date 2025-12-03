//
//  TabView.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/17/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    
    @Query(filter: #Predicate<User> { $0.active == true })
    private var activeUsers: [User]
    
    var body: some View {
        TabView{
            MainFeed()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            StartWorkout()
                .tabItem{
                    Label("Start Workout", systemImage: "plus.circle")
                }
            PostWorkout()
                .tabItem{
                    Label("Post Workout", systemImage: "square.and.arrow.up")
                }
            
            NavigationStack {
                if let active = activeUsers.first {
                    ProfileView(user: active)   // <-- NOW CORRECT
                } else {
                    Text("No active user found")
                }
            }
                 .tabItem{
                        Label("Profile", systemImage: "person.circle")
                    }
        }
    }
}

#Preview {
    TabBar()
}
