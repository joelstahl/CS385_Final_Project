//
//  TopFeedBar.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI
import SwiftData

struct TopFeedBar: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var users: [User]      // all users in the store
    @State private var activeUser: User?
    @State var showAddUserSheet: Bool = false
    var body: some View {
        HStack{
            Text("RateMyLift").font(.system(size:28, weight: .bold, design: .default))
                .kerning(0.5)
            Spacer()
            
            HStack(spacing: 16){
                Text(activeUser?.userName ?? "No User").font(.title3).bold().foregroundStyle(.red)
                
                Menu {
                    ForEach(users) { user in
                        Button {
                            setActive(user)
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
        .onAppear {
                    // pick the first active user if any, otherwise first user
                    if let alreadyActive = users.first(where: { $0.active }) {
                        activeUser = alreadyActive
                    } else {
                        activeUser = users.first
                    }
                }
        }
    private func setActive(_ user: User) {
        for u in users {
            u.active = (u.id == user.id)
        }
        activeUser = user

        do {
            try modelContext.save()
        } catch {
            print("Failed to save active user: \(error)")
        }
    }

    }


#Preview {
    TopFeedBar()
}
