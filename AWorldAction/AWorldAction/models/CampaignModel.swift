//
//  CampaignModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import Foundation
import Alamofire

public class CampaignsModel: ObservableObject {
    @Published var campaignList: [Campaign] = []
    
    func loadCampaigns() {
        
    }
}
