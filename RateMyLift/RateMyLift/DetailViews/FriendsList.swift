//
//  FriendsList.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct FriendsList: View {
    // Get the active user
    @Query(filter: #Predicate<User> { $0.active == true })
    private var activeUsers: [User]

    var friends: [User] {
        activeUsers.first?.friendsList ?? []
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    NavigationLink {
                        ProfileView(user: friend)    // <-- show their real profile
                    } label: {
                        HStack {
                            // Profile Circle
                            if let data = friend.profilePicture,
                               let img = UIImage(data: data) {
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(.gray.opacity(0.4))
                                    .frame(width: 36, height: 36)
                                    .overlay(Image(systemName: "person.fill"))
                            }

                            Text(friend.userName)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Friends")
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext

    // Example preview users
    let u1 = User(userName: "PreviewUser", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: true)
    let f1 = User(userName: "Cbum", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false)
    let f2 = User(userName: "TrenTwins", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false)

    u1.friendsList = [f1, f2]

    context.insert(u1)
    context.insert(f1)
    context.insert(f2)

    return FriendsList()
        .modelContainer(container)
}
