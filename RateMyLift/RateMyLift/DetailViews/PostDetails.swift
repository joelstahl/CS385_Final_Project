//
//  PostDetails.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/24/25.
//

import SwiftUI

struct PostDetails: View {
    let post: Post
    
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Post Details").font(.title).bold()
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
                HStack() {
                    Text(String(format: "%.1f", post.rating))
                    Image(systemName: "star.fill").foregroundStyle(.yellow)
                    Text("\(post.workout!.name)")
                }
                .font(.title2)
                .bold()
                .padding()
                Divider()
                
                HStack() {
                    Text("Total Cals:").bold()
                    Text(String(format: "%.1f", post.workout?.totalcalories ?? 0.0))
                    Text("Avg HR:").bold()
                    Text(String(format: "%.1f", post.workout?.avgHeartRate ?? 0.0))
                }
                .padding()
                ForEach(post.workout!.exercises){ exercise in
                    HStack{
                        Text(exercise.name + ":").bold()
                        ForEach(exercise.sets){ set in
                            Text("\(set.reps)x\(set.weight)")
                        }
                    }
                }
                
                
                Divider()
                Text("Comments:").padding().font(.title2).bold()
                ForEach(post.comment){ comment in
                    HStack{
                        Text(comment.user + ":").bold()
                        Text(comment.comment)
                    }
                }
            }
        }
    }
}

#Preview {
    PostDetails(post: Post(photo: nil, timestamp: Date(), caption: "This is a new post", rating: 8.8, comment: [Comment(timestamp: Date(), user: "Bob", comment: "This is a great post!")], workout: Workout()))
}
