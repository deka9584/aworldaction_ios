//
//  CampaignPicture.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import Foundation

struct CampaignPictureCollection: Codable {
    let data: [Campaign]?
    let message: String?
}

struct CampaignPictureResponse: Codable {
    let message: String?
    let data: CampaignPicture?
    let campaignPicture: CampaignPicture?
}

struct CampaignPicture: Codable, Identifiable {
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
