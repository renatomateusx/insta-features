//
//  Models.swift
//  InstaFeatures
//
//  Created by Renato Mateus on 12/03/21.
//

import Foundation
import UIKit

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
    let profilePhoto: URL
    
}
struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}


struct Constants  {
    static let padding: CGFloat = 8
    static let cornerRadius: CGFloat = 8.0
}


enum FollowStateType {
    case following, not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowStateType
}

struct EditProfileFormModel {
    let label:String
    let placeholder:String
    var value: String?
    
}


struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowStateType)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}
