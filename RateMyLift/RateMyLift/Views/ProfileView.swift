//
//  ProfileView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import SwiftUI

struct ProfileView: View {
    //Should take user in and query for [Post]
    @State var post: Post = Post()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let imageDimension = UIScreen.main.bounds.width / 3
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.title2)
                    
                    Spacer()
                    
                    Text("SamSulek")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Image(systemName: "checkmark.seal.fill").foregroundStyle(.red)
                    
                    Spacer()
                }
                
                HStack {
                    Image("Sam_and_cat")
                        .resizable()
                        .scaledToFill()
                        .frame(width:88, height: 88)
                        .clipShape(Circle())
                        
                    Spacer()
                    
                    HStack (spacing: 32){
                        VStack(spacing: 4){
                            Text("3,226")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Lifts")
                                .font(.caption)
                        }
                        VStack(spacing: 4){
                            Text("567")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Posts")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 4){
                            Text("120")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Friends")
                                .font(.caption)
                        }
                    }.padding(30)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Sam Sulek").font(.footnote).fontWeight(.semibold)
                    Text("I like cats, lifting, and clash royale").font(.footnote).fontWeight(.semibold)
                } .frame(maxWidth: .infinity, alignment: .leading).padding(.vertical, 4)
                
                HStack(spacing: -12){
                    Image("Sam_and_cat")
                        .resizable()
                        .scaledToFill()
                        .frame(width:32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image("Sam_and_cat")
                        .resizable()
                        .scaledToFill()
                        .frame(width:32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image("Sam_and_cat")
                        .resizable()
                        .scaledToFill()
                        .frame(width:32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    HStack (spacing: 2){
                        Text("Friends with")
                        Text("CBUM,Tren Twins").fontWeight(.semibold)
                        Text("and")
                        Text("2 others")
                    }
                    .font(.caption)
                    .padding(.leading)
                }
                
                HStack{
                    Button(action: {}) {
                        Text("View Friends")
                    }
                    
                    Button(action: {}) {
                        Text("Add Friend")
                            .tint(.red)
                    }
                }.buttonStyle(.borderedProminent).tint(.red).foregroundStyle(.white).padding(.vertical, 8)
                
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0..<15, id: \.self) { index in
                            NavigationLink{
                                PostDetails(post: post)
                            } label: {
                                PostCard()
                            }
                        }
                    }
                    
                }
                
                
            }
            .padding(8)
        }
    }
}


#Preview {
    NavigationStack {
        ProfileView()
    }
}
