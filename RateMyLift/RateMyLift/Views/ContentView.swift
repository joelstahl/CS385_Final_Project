//
//  ContentView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
            TabBar()
        }
        
    }
#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
