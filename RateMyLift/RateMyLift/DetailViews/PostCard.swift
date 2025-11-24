//
//  PostCard.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/24/25.
//

import SwiftUI

struct PostCard: View {
    
    var body: some View {
        Image("Sam_and_cat")
            .resizable()
            .scaledToFit()
            .symbolRenderingMode(.hierarchical)
            .frame(maxWidth: 160, minHeight: 160, maxHeight: 160)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.quaternary, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.3), radius: 15, x:0, y:10)
    }
}


#Preview {
    PostCard()
}
