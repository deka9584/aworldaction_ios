//
//  CreateCampaignModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import Foundation
import Alamofire
import CoreLocation

public class CreateCampaignModel: ObservableObject {
    @Published var loading = false
    @Published var success = false
    @Published var createdId = 0
    
    func postCampaign(usrToken: String, name: String, description: String, locality: String, location: CLLocationCoordinate2D) {
        let url = apiUrl + "/campaigns"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "location_name": locality,
            "location_lat": location.latitude,
            "location_lng": location.longitude
        ]
        
        loading = true
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 201 {
                        self.success = true
                    }
                    
                    if let campaign = responseData.campaign {
                        self.createdId = campaign.id
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
    }
}
