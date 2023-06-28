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
            .responseDecodable(of: CampaignResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let campaign = responseData.data {
                        campaign.pictures?.forEach({ picture in
                            self.pictures.append(picture)
                        })
                        
                        campaign.contributors?.forEach({ contributor in
                            self.contributors.append(contributor)
                        })
                        
                        self.campaign = campaign
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
        let parameters: [String: Any] = [
            "campaign_id": campaignId,
            "body": body
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let comment = responseData.comment {
                        self.comments.append(comment)
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func deleteComment(usrToken: String, commentId: Int) {
        let url = apiUrl + "/comments/" + String(commentId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 200 {
                        self.comments.removeAll { $0.id == commentId }
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func editComment(usrToken: String, commentId: Int, body: String) {
        let url = apiUrl + "/comments/" + String(commentId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let parameters = [
            "body": body
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                case.success(let responseData):
                    if let comment = responseData.comment {
                        for (index, existingComment) in self.comments.enumerated() {
                            if existingComment.id == comment.id {
                                self.comments[index] = comment
                                break
                            }
                        }
                    }
                    
                    print(responseData)
                    
                case.failure(let error):
                    print(error)
                }
            }
    }
}
