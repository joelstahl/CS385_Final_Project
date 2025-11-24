//
//  PostView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI

struct PostView: View {
    var username: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Circle()
                    .fill(.gray.opacity(0.4))
                    .frame(width: 36, height: 36)
                    .overlay(Image(systemName: "person.fill"))
                VStack(alignment: .leading, spacing: 2){
                    Text(username).font(.subheadline)
                }
                Spacer()
                Button(action: {}){
                    Text("Add Friend")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button(action: {}){
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundStyle(.red)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            ZStack{
                Rectangle()
                    .fill(Color.gray.opacity(0.25))
                    .frame(maxWidth: .infinity) //Can add height: to make image smaller
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(Image(systemName:"photo"))
            }
            HStack{
                HStack(spacing: 8){
                    Text("7.5").font(.title2)
                    Button(action: {}){
                        Image(systemName: "mount.fill").font(.title2)
                    }
                    .tint(.red)
                    Button(action: {}){
                        Image(systemName: "bubble.right.fill").font(.title2)
                    }
                    .tint(.red)
                }
                .padding(.vertical , 2)
                .padding(.horizontal)
            }
            VStack(alignment: .leading, spacing: 2){
                Text("\(Text(username).fontWeight(.semibold)) This is a great place to go for a Chest Day!").lineLimit(2)
                Text("4 hours ago").font(.caption).foregroundStyle(.secondary)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    PostView(username: "Sam Sulek")
}
