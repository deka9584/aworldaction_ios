//
//  UserResponse.swift
//  AWorldAction
//
//  Created by Andrea Sala on 19/05/23.
//

import Foundation

struct LoggedUser: Codable {
    let created_at: String
    let email: String
    let email_verified_at: String?
    let id: Int
    let name: String
    let picture_path: String?
    let role_id: Int
    let updated_at: String
}
