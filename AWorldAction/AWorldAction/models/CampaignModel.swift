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
    @Published var contributors: [UserProfile] = []
    @Published var comments: [Comment] = []
    @Published var loading = false
    
    func fetch(usrToken: String, campaignId: Int) {
        let url = apiUrl + "/campaigns/" + String(campaignId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        loading = true
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: [String: Campaign].self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let data = responseData["data"] {
                        data.pictures?.forEach({ picture in
                            self.pictures.append(picture)
                        })
                        
                        data.contributors?.forEach({ contributor in
                            self.contributors.append(contributor)
                        })
                        
                        self.campaign = data
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
        
        loadComments(headers: headers, campaignId: campaignId)
    }
    
    func loadComments(headers: HTTPHeaders, campaignId: Int) {
        let url = apiUrl + "/comments/filter/" + String(campaignId)
        
        comments.removeAll()
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentCollection.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    responseData.data?.forEach({ comment in
                        self.comments.append(comment)
                    })
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func insertComment(usrToken: String, campaignId: Int, body: String) {
        let url = apiUrl + "/comments"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let body: [String: Any] = [
            "campaign_id": campaignId,
            "body": body
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let comment = responseData.comment {
                        self.loadComments(headers: headers, campaignId: campaignId)
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func deleteComment(usrToken: String, comment: Comment) {
        let url = apiUrl + "/comments/" + String(comment.id)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 200 {
                        self.loadComments(headers: headers, campaignId: comment.campaign_id)
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
