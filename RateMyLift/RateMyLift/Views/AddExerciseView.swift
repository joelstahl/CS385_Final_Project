//
//  AddExerciseView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var sets: Int = 0
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Name")){
                    TextField("Name", text: $name)
                }
                Section(header: Text("Sets")){
                    Stepper("Sets \(sets)", value: $sets, in: 1...10)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Save") {
//                        let exercise = Exercise(
//                            name: name,
//                            sets: sets
//                        )
//                        addExercise(exercise)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddExerciseView()
}
