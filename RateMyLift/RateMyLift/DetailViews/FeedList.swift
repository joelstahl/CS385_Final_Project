//
//  FeedList.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI
import SwiftData

struct FeedList: View {
    let posts: [Post]

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(posts) { post in
                PostView(post: post)
            }
        }
    }
}

#Preview {
    // In-memory container just for preview
    let container = try! ModelContainer(
        for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    // Dummy user + post(s) for preview
    let user = User(
        userName: "Preview User",
        profilePicture: nil,
        name: "Cool guy",
        bio: "Im a cool guy",
        posts: [],
        friendsList: [],
        workouts: [],
        active: true
    )

    let post1 = Post(
        photo: nil,
        timestamp: .now,
        caption: "Preview chest day post!",
        rating: 8.0,
        comment: [],
        author: user,
        workout: nil
    )

    let post2 = Post(
        photo: nil,
        timestamp: .now.addingTimeInterval(-3600),
        caption: "Back day pump!",
        rating: 7.0,
        comment: [],
        author: user,
        workout: nil
    )

    context.insert(user)
    context.insert(post1)
    context.insert(post2)

    return FeedList(posts: [post1, post2])
        .modelContainer(container)
}
