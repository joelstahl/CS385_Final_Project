//
//  FriendsList.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI

struct FriendsList: View {
    @State var friendsList: [User] = [User(userName: "CBUM", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "TrenTwins", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "Arnold", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "Matt", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "TheRock", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false)
    ]
    
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(friendsList){ friend in
                    HStack{
                        Circle()
                            .fill(.gray.opacity(0.4))
                            .frame(width: 36, height: 36)
                            .overlay(Image(systemName: "person.fill"))
                        Text(friend.userName)
                        NavigationLink("", destination: ProfileView())
                            //ProfileView(user: friend)
                                                    
                    }
                }
            }
            .navigationTitle(Text("Friends"))
        }
    }
}

#Preview {
    FriendsList()
}
