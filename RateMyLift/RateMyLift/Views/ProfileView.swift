//
//  ProfileView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Bindable var user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Profile picture
                if let data = user.profilePicture,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .overlay(Image(systemName: "person.fill").font(.largeTitle))
                }

                // Username
                Text(user.userName)
                    .font(.title)
                    .bold()

                // Friend count (if you use this)
                Text("\(user.friendsList.count) Friends")
                    .foregroundStyle(.secondary)

                Divider().padding(.horizontal)

                // Posts header
                Text("Posts")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // This shows all posts by this user
                LazyVStack(spacing: 0) {
                    ForEach(user.posts) { post in
                        PostView(post: post)
                    }
                }
            }
            .padding(.top, 24)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext

    let user = User(
        userName: "Preview User",
        profilePicture: nil,
        posts: [],
        friendsList: [],
        workouts: [],
        active: true
    )

    context.insert(user)

    return ProfileView(user: user)
        .modelContainer(container)
}
