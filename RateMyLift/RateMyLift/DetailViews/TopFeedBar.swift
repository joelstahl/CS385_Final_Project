//
//  TopFeedBar.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/23/25.
//

import SwiftUI

struct TopFeedBar: View {
    var body: some View {
        HStack{
            Text("RateMyLift").font(.system(size:28, weight: .bold, design: .default))
                .kerning(0.5)
            Spacer()
            
            HStack(spacing: 16){
                Button(action: {}) {
                    Image(systemName: "person.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                }
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                }
            }
        }
        .padding()
    }
}

#Preview {
    TopFeedBar()
}
