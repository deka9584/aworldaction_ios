//
//  Campaign.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/06/23.
//

import Foundation

struct CampaignCollection: Codable {
    let data: [Campaign]?
    let message: String?
}

struct Campaign: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let location_name: String?
    let location_lat: Double
    let location_lng: Double
    let completed: Int
    let created_at: String
    let updated_at: String
}
