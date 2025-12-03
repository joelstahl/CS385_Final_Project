//
//  PostView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

//
//  PostView.swift
//  RateMyLift
//

import SwiftUI
import SwiftData

struct PostView: View {

    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<User> { $0.active == true })
    private var activeUsers: [User]

    @Bindable var post: Post

    @State private var showRatingSheet = false
    @State private var showCommentSheet = false
    @State private var newCommentText = ""
    @State private var showProfileViewSheet = false

    private var author: User? { post.author }
    private var username: String { author?.userName ?? "Unknown User" }
    private var activeUser: User? { activeUsers.first }

    // Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // -------------------------------
            // HEADER
            // -------------------------------
            HStack(spacing: 12) {

                // Profile picture
                if let data = author?.profilePicture,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(.gray.opacity(0.4))
                        .frame(width: 40, height: 40)
                        .overlay(Image(systemName: "person.fill"))
                }

                Button {
                    showProfileViewSheet = true
                } label: {
                    Text(username)
                        .font(.headline)
                        .foregroundStyle(.black)
                }

                Spacer()

                // Friend Button — FIXED (no more maxWidth)
                Button(action: toggleFriend) {
                    Text(isFriend ? "Friends ✓" : "Add Friend")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
                .tint(isFriend ? .green : .red)
                .controlSize(.small)

            }
            .padding(.horizontal)

            // -------------------------------
            // IMAGE
            // -------------------------------
            if let data = post.photo,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.25))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                    )
            }

            // -------------------------------
            // RATING + COMMENT BUTTONS
            // -------------------------------
            HStack(spacing: 16) {

                Text(String(format: "%.1f", post.rating))
                    .font(.title3.bold())

                Button { showRatingSheet = true } label: {
                    Image(systemName: "star.circle.fill")
                        .font(.title2)
                }
                .tint(.red)

                Button { showCommentSheet = true } label: {
                    Image(systemName: "bubble.right.fill")
                        .font(.title2)
                }
                .tint(.red)

                Spacer()
            }
            .padding(.horizontal)

            // -------------------------------
            // COMMENTS
            // -------------------------------
            VStack(alignment: .leading, spacing: 8) {
                ForEach(post.comment) { c in
                    HStack(alignment: .top, spacing: 6) {
                        Text(c.user)
                            .font(.caption)
                            .fontWeight(.bold)

                        Text(c.comment)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .padding(.vertical, 8)  // <-- gives each post breathing room
        .sheet(isPresented: $showRatingSheet) { RateWorkout(post: post) }
        .sheet(isPresented: $showCommentSheet) {
            CommentSheet(commentText: $newCommentText) {
                saveComment(newCommentText)
                newCommentText = ""
            }
        }
        .sheet(isPresented: $showProfileViewSheet) {
            if let author = post.author {
                ProfileView(user: author)
            } else {
                Text("User not found")
            }
        }
    }

    //Friend Logic
    private var isFriend: Bool {
        guard let me = activeUser, let author = author else { return false }
        return me.friendsList.contains(where: { $0.id == author.id })
    }

    private func toggleFriend() {
        guard let me = activeUser, let author = author else { return }

        if isFriend {
            me.friendsList.removeAll(where: { $0.id == author.id })
        } else {
            me.friendsList.append(author)
        }

        try? modelContext.save()
    }

    private func saveComment(_ text: String) {
        guard let active = activeUser else { return }
        let newComment = Comment(timestamp: Date(), user: active.userName, comment: text)
        post.comment.append(newComment)
        try? modelContext.save()
    }
}


//Preview
#Preview {
    let container = try! ModelContainer(
        for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self
    )
    let context = container.mainContext

    let user = User(
        userName: "Sam Sulek",
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
        rating: 7.5,
        comment: [],
        author: user,
        workout: nil
    )

    context.insert(user)
    context.insert(post)

    return PostView(post: post)
        .modelContainer(container)
}
