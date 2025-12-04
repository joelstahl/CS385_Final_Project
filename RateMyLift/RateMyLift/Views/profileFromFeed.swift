//
//  profileFromFeed.swift
//  RateMyLift
//
//  Created by Joel Stahl on 12/3/25.
//

import SwiftUI
import SwiftData

struct profileFromFeedView: View {

    @State var post: Post = Post()
    @Bindable var user: User
    @State var showFriendsList = false
    
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<User> { $0.active == true })
    var activeUsers: [User]
    var activeUser: User? { activeUsers.first }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let imageDimension = UIScreen.main.bounds.width / 3

    var body: some View {
        ScrollView{
                   VStack{
                       HStack{
                           
                           Spacer()
                           
                           Text(user.userName)
                               .font(.subheadline)
                               .fontWeight(.semibold)
                           Image(systemName: "checkmark.seal.fill").foregroundStyle(.red)
                           
                           Spacer()
                       }
                       
                       HStack {
                           if let data = user.profilePicture,
                              let uiImage = UIImage(data: data) {
                               Image(uiImage: uiImage)
                                   .resizable()
                                   .scaledToFill()
                                   .frame(width:88, height: 88)
                                   .clipShape(Circle())
                           } else {
                               Circle()
                                   .frame(width:88, height: 88)
                                   .overlay(
                                       Image(systemName: "photo")
                                           .font(.largeTitle)
                                           .foregroundStyle(.gray)
                                   )
                           }
                               
                           Spacer()
                           
                           HStack (spacing: 32){
                               VStack(spacing: 4){
                                   Text("\(user.workouts.count)")
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                   Text("Lifts")
                                       .font(.caption)
                               }
                               VStack(spacing: 4){
                                   Text("\(user.posts.count)")
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                   Text("Posts")
                                       .font(.caption)
                               }
                               
                               VStack(spacing: 4){
                                   Text("\(user.friendsList.count)")
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                   Text("Friends")
                                       .font(.caption)
                               }
                           }.padding(30)
                       }
                       
                       VStack(alignment: .leading, spacing: 2) {
                           Text("Sam Sulek").font(.footnote).fontWeight(.semibold)
                           Text("I like cats, lifting, and clash royale").font(.footnote).fontWeight(.semibold)
                       } .frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 4)
                       
                       HStack{
                           Button{
                               showFriendsList = true
                           }
                           label: {
                               Text("View Friends")
                           }
                           
                           Button(action: toggleFriend) {
                               Text(isFriend ? "Friends ✓" : "Add Friend")
                                   .padding(.horizontal, 16)
                                   .padding(.vertical, 6)
                           }
                           .buttonStyle(.borderedProminent)
                           .tint(isFriend ? .green : .red)
                           .controlSize(.small)
                       }.buttonStyle(.borderedProminent).tint(.red).foregroundStyle(.white).padding(.vertical, 8)
                       
                       LazyVGrid(columns: columns, spacing: 0){
                           ForEach(user.posts){ post in
                               if let data = post.photo,
                                  let uiImage = UIImage(data: data) {
                                   Image(uiImage: uiImage)
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: imageDimension, height: imageDimension)
                                       .border(Color.white)
                                       .clipped()
                               } else {
                                   Rectangle()
                                       .frame(width: imageDimension, height: imageDimension)
                                       .border(Color.white)
                                       .clipped()
                                       .overlay(
                                           Image(systemName: "photo")
                                               .font(.largeTitle)
                                               .foregroundStyle(.gray)
                                       )
                               }
                           }
                       }
                   }
                   .sheet(isPresented: $showFriendsList) { FriendsList() }
                   .padding(8)
        }
    }
    private var isFriend: Bool {
        guard let me = activeUser else { return false }
        return me.friendsList.contains(where: { $0.id == user.id })
    }

    private func toggleFriend() {
        guard let me = activeUser else { return }

        if isFriend {
            me.friendsList.removeAll(where: { $0.id == user.id })
        } else {
            me.friendsList.append(user)
        }

        try? modelContext.save()
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

    return profileFromFeedView(user: user)
        .modelContainer(container)
}

