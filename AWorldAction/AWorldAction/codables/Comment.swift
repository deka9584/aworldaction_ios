//
//  Comment.swift
//  AWorldAction
//
//  Created by Andrea Sala on 09/06/23.
//

import Foundation

struct CommentCollection: Codable {
    let data: [Comment]?
    let message: String?
}

struct CommentResponse: Codable {
    let message: String?
    let data: Comment?
    let comment: Comment?
}

struct Comment: Codable, Identifiable {
    let id: Int
    let body: String
    let user_id: Int
    let user_name: String
    let picture_path: String?
    let campaign_id: Int
    let created_at: String
    let updated_at: String
}
