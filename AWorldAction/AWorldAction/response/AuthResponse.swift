//
//  User.swift
//  AWorldAction
//
//  Created by Andrea Sala on 19/05/23.
//

import Foundation

struct AuthResponse: Codable {
    let token: String
    let user: User
}
