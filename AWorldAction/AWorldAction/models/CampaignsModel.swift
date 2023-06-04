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
    @Published var loading = false
    @Published var failed = false
    @Published var statusCode: Int?
    
    func loadCampaigns(appSettings: AppSettings) {
        let url = apiUrl + "/campaigns"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: appSettings.usrToken),
            .accept("application/json")
        ]
        
        loading = true
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignCollection.self) { response in
                switch response.result {
                    case .success(let responseData):
                    if response.response?.statusCode == 401 {
                        self.failed = true
                    }
                    
                    if let data = responseData.data {
                        self.campaignList = data
                    }
                    
                    if let message = responseData.message {
                        print(message)
                    }
                    
                    self.failed = false
                    
                    case .failure(let error):
                    self.failed = true
                    print(error)
                }
                
                self.loading = false
            }
    }
}
