//
//  CampaignModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/06/23.
//

import Foundation
import Alamofire

public class CampaignModel: ObservableObject {
    @Published var campaign: Campaign?
    @Published var pictures: [CampaignPictures] = []
    @Published var loading = false
    
    func fetch(appSettings: AppSettings, campaignId: Int) {
        let url = apiUrl + "/campaigns/" + String(campaignId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: appSettings.usrToken),
            .accept("application/json")
        ]
        
        loading = true
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: [String: Campaign].self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    print(responseData)
                    
                    if let data = responseData["data"] {
                        data.pictures?.forEach({ picture in
                            self.pictures.append(picture)
                        })
                        
                        self.campaign = data
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
    }
}
