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

struct CampaignResponse: Codable {
    let message: String?
    let data: Campaign?
    let campaign: Campaign?
}

struct Campaign: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let location_name: String?
    let location_lat: Double
    let location_lng: Double
    let completed: Int?
    let pictures: [CampaignPicture]?
    let contributors: [UserProfile]?
    let creator_id: [Int]?
    let created_at: String
    let updated_at: String
}
