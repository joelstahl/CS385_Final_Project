//
//  TabView.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/17/25.
//

import SwiftUI

struct TabBar: View {
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
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person.circle")
                }
            
        }
    }
}

#Preview {
    TabBar()
}
