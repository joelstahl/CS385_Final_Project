//
//  MainFeed.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI
import SwiftData

struct MainFeed: View {
    @Query(sort: \Post.timestamp, order: .reverse)
       private var posts: [Post]
    
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea(.all)
            VStack(spacing: 0){
                TopFeedBar()
                Divider()
                ScrollView(showsIndicators: false){
                    VStack(spacing:0){
                        FeedList(posts: posts)
                    }
                }
            }
        }
    }
}

#Preview {
    MainFeed()
}
