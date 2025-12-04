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
    
    @State var showAddSetSheet = false
    
    @State private var name: String = ""
    let addExercise: (Exercise) -> Void
    @State var sets: [Sets] = []
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Name")){
                    TextField("Name", text: $name)
                }
                Button(action: {
                    showAddSetSheet = true
                }) {
                    Text("Add Set")
                }
                ForEach(sets){
                     set in
                    Text("\(set.reps)x\(set.weight) lbs")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Save") {
                        let exercise = Exercise(
                            name: name,
                            sets: sets,
                        )
                        addExercise(exercise)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .sheet(isPresented: $showAddSetSheet){
                AddSetsView {
                    set in
                    sets.append(set)
                }
            }
        }
    }
}

#Preview {
    AddExerciseView(addExercise: {_ in})
}
