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
    let pictures: [CampaignPictures]?
    let created_at: String
    let updated_at: String
}

struct CampaignPictures: Codable {
    let id: Int
    let path: String
    let caption: String
    let campaign_id: Int
    let user_id: Int
    let created_at: String
    let updated_at: String
    
    func getUrl() -> URL {
        let serverUrl = apiUrl.replacingOccurrences(of: "api", with: "storage")
        let newUrl = path.replacingOccurrences(of: "public", with: serverUrl)
        return URL(string: newUrl)!
    }
}
