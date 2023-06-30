//
//  CampaignModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import Foundation
import Alamofire

public class CampaignListModel: ObservableObject {
    var toShow: String // inprogress / favourites / completed
    @Published var campaignList: [Campaign] = []
    @Published var loading = false
    @Published var failed = false
    @Published var statusCode: Int?
    
    init(toShow: String) {
        self.toShow = toShow
    }
    
    func loadCampaigns(usrToken: String) { // Carica lista campagne
        let url = apiUrl + "/" + toShow
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        loading = true
        campaignList.removeAll() // Pulisce lista corrente
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignCollection.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    self.failed = response.response?.statusCode != 200
                    
                    if let message = responseData.message {
                        print(message)
                    }
                    
                    responseData.data?.forEach({ campaign in
                        self.campaignList.append(campaign) // Aggiunge nuovi elementi alla lista
                    })
                    
                case .failure(let error):
                    self.failed = true
                    print(error)
                }
                
                self.loading = false
            }
    }
}
