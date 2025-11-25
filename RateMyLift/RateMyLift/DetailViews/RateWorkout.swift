//
//  RateWorkout.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/25/25.
//

import SwiftUI

struct RateWorkout: View {
    @Environment(\.dismiss) private var dismiss
    @State var rating: Int = 7
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Text("Rate Your Workout")
                    .font(.title2.bold())
                
                // Big Number
                Text("\(rating) / 10")
                    .font(.system(size: 48, weight: .bold))
                    .padding(.bottom, 8)
                
                
                // Dots + Numbers
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        ForEach(1...10, id: \.self) { value in
                            VStack(spacing: 4) {
                                Circle()
                                    .fill(value <= rating ? Color.red : Color.gray.opacity(0.3))
                                    .frame(width: 22, height: 22)
                                
                                Text("\(value)")
                                    .font(.caption2)
                                    .foregroundStyle(
                                        value == rating ? .primary : .secondary
                                    )
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    rating = value
                                }
                            }
                        }
                    }
                    
                    Text("Rating: \(rating) / 10")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                .padding(.horizontal)
                .padding()
                .presentationDetents([.fraction(0.45), .large])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    RateWorkout()
}
