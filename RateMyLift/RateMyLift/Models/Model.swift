//
//  Item.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import Foundation
import SwiftData

@Model
final class User {
    var timestamp: Date
    var userName: String
    var profilePicture: Data?
    var posts: [Post]
    var friendsList: [User]
    var active: Bool
    

    init(timestamp: Date, userName: String, profilePicture: Data?, posts: [Post], friendsList: [User], active: Bool = false) {
        self.timestamp = timestamp
        self.userName = userName
        self.profilePicture = profilePicture
        self.posts = posts
        self.friendsList = friendsList
        self.active = active
    }
    
    init() {
        self.timestamp = Date()
        self.userName = "New User"
        self.profilePicture = nil
        self.posts = []
        self.friendsList = []
        self.active = false
    }
}

@Model
final class Post {
    var photo: Data?
    var timestamp: Date
    var caption: String
    var rating: Float
    var comment: [Comment]

    @Relationship(inverse: \User.posts)
    var author: User?      // <— who made the post, this is used for the main feed instead of
                           // going through every users post array
    init(photo: Data?, timestamp: Date, caption: String, rating: Float, comment: [Comment], author: User? = nil) {
        self.photo = photo
        self.timestamp = timestamp
        self.caption = caption
        self.rating = rating
        self.comment = comment
        self.author = author
    }
    
    init() {
        self.photo = nil
        self.timestamp = Date()
        self.caption = "This is a new post"
        self.rating = 7.5
        self.comment = [Comment()]
        self.author = User()
    }
}


@Model
final class Comment {
    var timestamp: Date
    var user: String
    var comment: String
    
    
    init(timestamp: Date, user: String, comment: String) {
        self.timestamp = timestamp
        self.user = user
        self.comment = comment
    }
    
    init() {
        self.timestamp = Date()
        self.user = "Anonymous"
        self.comment = "This is a new comment"
    }
}
