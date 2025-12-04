//
//  AddSetsView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 12/3/25.
//

import SwiftUI

struct AddSetsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var weight: Int = 0
    @State private var reps: Int = 0
    
    let addSet: (Sets) -> Void
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Reps")){
                    TextField("Enter a number", value: $reps, formatter: NumberFormatter())
                }
                Section(header: Text("Weight")){
                    TextField("Enter a number", value: $weight, formatter: NumberFormatter())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Save") {
                        let set = Sets(
                            weight: weight,
                            reps: reps,
                        )
                        addSet(set)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddSetsView(addSet: {_ in})
}
