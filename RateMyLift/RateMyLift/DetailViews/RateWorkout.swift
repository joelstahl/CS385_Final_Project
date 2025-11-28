//
//  RateWorkout.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/25/25.
//

import SwiftUI
import SwiftData

struct RateWorkout: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Bindable var post: Post
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
                    saveAndDismiss()
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
            }
        }
        .presentationDetents([.fraction(0.45), .large])
        .presentationDragIndicator(.visible)
        .onAppear {
            rating = max(1, min(10, Int(post.rating.rounded())))
        }
    }

    private func saveAndDismiss() {
        post.rating = Float(rating)

        do {
            try modelContext.save()
        } catch {
            print("Failed to save rating: \(error)")
        }

        dismiss()
    }
}

#Preview {
    // In-memory container for preview
    let container = try! ModelContainer(
        for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    // Dummy user + post for preview
    let user = User(
        userName: "Preview User",
        profilePicture: nil,
        posts: [],
        friendsList: [],
        workouts: [],
        active: true
    )

    let post = Post(
        photo: nil,
        timestamp: .now,
        caption: "Preview chest day post!",
        rating: 7.0,
        comment: [],
        author: user,
        workout: nil
    )

    context.insert(user)
    context.insert(post)

    return RateWorkout(post: post)
        .modelContainer(container)
}
