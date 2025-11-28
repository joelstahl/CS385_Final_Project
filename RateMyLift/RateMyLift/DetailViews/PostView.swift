//
//  PostView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct PostView: View {
    @Bindable var post: Post      // <-- SwiftData model we’re showing/editing

    @State private var showRatingSheet = false
    @State private var showCommentSheet = false
    @State private var newCommentText: String = ""
    @State private var showProfileViewSheet: Bool = false

    // Convenience: current author + username
    private var author: User? {
        post.author
    }

    private var username: String {
        author?.userName ?? "Unknown User"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            HStack {
                // Profile picture
                if let data = author?.profilePicture,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
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

                VStack(alignment: .leading, spacing: 2) {
                    Button {
                        showProfileViewSheet = true
                    } label: {
                        Text(username)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                }

                Spacer()

                Button(action: {
                }) {
                    Text("Add Friend")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            ZStack {
                if let data = post.photo,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.25))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        )
                }
            }

            HStack {
                HStack(spacing: 8) {
                    // Current rating from the model
                    Text(String(format: "%.1f", post.rating))
                        .font(.title2)

                    Button {
                        showRatingSheet = true
                    } label: {
                        Image(systemName: "star.circle.fill")   // or your mountain icon
                            .font(.title2)
                    }
                    .tint(.red)

                    Button {
                        showCommentSheet = true
                    } label: {
                        Image(systemName: "bubble.right.fill")
                            .font(.title2)
                    }
                    .tint(.red)
                }
                .padding(.vertical, 2)
                .padding(.horizontal)

                Spacer()
            }
            HStack {
                (
                    Text(username).fontWeight(.semibold)
                    + Text(" ")
                    + Text(post.caption)
                )
                .lineLimit(2)

                Spacer()
            }

            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .sheet(isPresented: $showRatingSheet) {
            // Make sure RateWorkout has init(post: Post) and saves post.rating
            RateWorkout(post: post)
        }
        .sheet(isPresented: $showCommentSheet) {
            CommentSheet(commentText: $newCommentText) {
                // TODO: later, create a Comment(model) and append to post.comment, then save
                print("User wrote comment: \(newCommentText)")
            }
        }
        .sheet(isPresented: $showProfileViewSheet) {
            // You can later add a ProfileView(user: author) if you want
            ProfileView()
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: User.self, Post.self, Workout.self, Exercise.self, Sets.self, Comment.self)
    let context = container.mainContext

    let user = User(userName: "Sam Sulek",
                    profilePicture: nil,
                    posts: [],
                    friendsList: [],
                    workouts: [],
                    active: true)

    let post = Post(photo: nil,
                    timestamp: .now,
                    caption: "This is a preview chest day post!",
                    rating: 7.5,
                    comment: [],
                    author: user,
                    workout: nil)

    context.insert(user)
    context.insert(post)

    return PostView(post: post)
        .modelContainer(container)
}
