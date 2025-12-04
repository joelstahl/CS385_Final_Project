//
//  Item.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//

import Foundation
import SwiftData
import PhotosUI

@Model
final class User {
    var userName: String
    var profilePicture: Data?
    var name: String?
    var bio: String?
    var posts: [Post]
    var friendsList: [User]
    var workouts: [Workout]
    var active: Bool
    

    init( userName: String, profilePicture: Data?, name: String?, bio: String?, posts: [Post], friendsList: [User], workouts: [Workout], active: Bool = false) {
        self.userName = userName
        self.profilePicture = profilePicture
        self.name = name
        self.bio = bio
        self.posts = posts
        self.friendsList = friendsList
        self.workouts = workouts
        self.active = active
    }
    
    init() {
        self.userName = "Current User"
        self.name = "My name"
        self.bio = "My bio I like to lift and stuff"
        self.profilePicture = nil
        self.posts = [Post()]
        self.friendsList = []
        self.workouts = []
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
    var workout: Workout?

    @Relationship(inverse: \User.posts)
    var author: User?      // <— who made the post, this is used for the main feed instead of
                           // going through every users post array
    init(photo: Data?, timestamp: Date, caption: String, rating: Float, comment: [Comment], author: User? = nil, workout: Workout? = nil) {
        self.photo = photo
        self.timestamp = timestamp
        self.caption = caption
        self.rating = rating
        self.comment = comment
        self.author = author
        self.workout = workout
    }
    
    
    init() {
        self.photo = nil
        self.timestamp = Date()
        self.caption = "This is a new post"
        self.rating = 7.5
        self.comment = [Comment()]
        self.author = nil
        self.workout = Workout()
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
