//
//  FeedList.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI

struct FeedList: View {
    var body: some View {
        LazyVStack(spacing: 0){
            ForEach(0..<16){ index in
                PostView(username: "Sam Sulek\(index)")
                
            }
        }
    }
}

#Preview {
    FeedList()
}
