//
//  Campaign.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/06/23.
//

import Foundation

struct Campaign: Codable {
    let id: Int
    let name: String
    let description: String
    let location_name: String?
    let location_lat: Double
    let location_lng: Double
    let completed: Bool
    let created_at: String
    let updated_at: String
}
