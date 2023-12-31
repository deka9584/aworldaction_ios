//
//  UserProfile.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/06/23.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: Int
    let name: String
    let picture_path: String?
    let role_id: Int?
    let created_at: String?
}
