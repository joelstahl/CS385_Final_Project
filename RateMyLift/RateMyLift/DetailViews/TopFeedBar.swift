//
//  TopFeedBar.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI

struct TopFeedBar: View {
    @State var activeUser: User = User()
    @State var showAddUserSheet: Bool = false
    
    
    @State var users: [User] = [User(userName: "CBUM", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "TrenTwins", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "Arnold", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "Matt", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false),
                                      User(userName: "TheRock", profilePicture: nil, posts: [], friendsList: [], workouts: [], active: false)
    ]
    
    var body: some View {
        HStack{
            Text("RateMyLift").font(.system(size:28, weight: .bold, design: .default))
                .kerning(0.5)
            Spacer()
            
            HStack(spacing: 16){
                Text(activeUser.userName).font(.title3).bold().foregroundStyle(.red)
                
                Menu {
                    ForEach(users) { user in
                        Button {
                            activeUser = user
                        } label: {
                            Text(user.userName)
                        }
                    }
                } label: {
                    Image(systemName: "person.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                }
            }
            Button{
                showAddUserSheet = true
            } label: {
                Image(systemName: "plus").font(.title2)
            }
            .foregroundStyle(.black)
            }
        .padding()
        .sheet(isPresented: $showAddUserSheet) {
            CreateUserView()
        }
//        .onAppear {
//            // Optional: default to first user
//            if activeUser == nil {
//                activeUser = users.first
//            }
//        }
        }
    }


#Preview {
    TopFeedBar()
}
