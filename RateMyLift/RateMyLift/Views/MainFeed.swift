//
//  MainFeed.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct MainFeed: View {
    @Query(
            sort: \Post.timestamp,
            order: .reverse)   // newest first
        
        private var posts: [Post]

        var body: some View {
            List(posts) { post in
                VStack(alignment: .leading, spacing: 8) {
                    // author info
                    if let user = post.author {
                        HStack {
                            if let data = user.profilePicture,
                               let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                            Text(user.userName)
                                .font(.headline)
                        }
                    }

                    // photo
                    if let data = post.photo,
                       let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .clipped()
                    }

                    // caption
                    Text(post.caption)
                        .font(.body)
                    Text(post.timestamp, style: .time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }
        }
    }


#Preview {
    MainFeed()
}
