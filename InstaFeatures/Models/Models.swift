//
//  Models.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//

import Foundation
public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let identifier:String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
}

struct PostLike{
    let username: String
    let postIdentifier: String
}
struct CommentLike {
    let username: String
    let postIdentifier: String
}
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
enum Gender {
    case male, female, other
}
struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
    
}
struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}
