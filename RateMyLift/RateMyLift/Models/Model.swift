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
}

@Model
final class Post {
    var photo: Data?
    var timestamp: Date
    var caption: String
    var rating: Float
    var comment: [Comment]
    
    init(photo: Data?, timestamp: Date, caption: String, rating: Float, comment: [Comment]) {
        self.photo = photo
        self.timestamp = timestamp
        self.caption = caption
        self.rating = rating
        self.comment = comment
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
}
