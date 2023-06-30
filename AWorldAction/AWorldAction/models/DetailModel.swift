//
//  CampaignModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/06/23.
//

import Foundation
import Alamofire
import CoreLocation

public class DetailModel: ObservableObject {
    @Published var campaign: Campaign?
    @Published var pictures: [CampaignPicture] = []
    @Published var contributors: [UserProfile] = []
    @Published var comments: [Comment] = []
    @Published var loading = false
    @Published var deleted = false
    
    func fetch(usrToken: String, campaignId: Int) { // Carica la campagna dal server
        let url = apiUrl + "/campaigns/" + String(campaignId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        loading = true
        pictures.removeAll()
        contributors.removeAll()
        comments.removeAll()
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let campaign = responseData.data {
                        campaign.pictures?.forEach({ picture in
                            self.pictures.append(picture) // Carica immagini campagna
                        })
                        
                        campaign.contributors?.forEach({ contributor in
                            self.contributors.append(contributor) // Carica contributori
                        })
                        
                        self.campaign = campaign // Carica instanza modello campagna
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
        
        loadComments(headers: headers, campaignId: campaignId)
    }
    
    func update(usrToken: String, campaignId: Int, campaignStatus: Bool) { // Update campagna
        guard let campaign = self.campaign else { return }
        let url = apiUrl + "/campaigns/" + String(campaignId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let body: [String : Any] = [
            "name": campaign.name,
            "description": campaign.description,
            "completed": campaignStatus ? 1 : 0
        ]
        
        loading = true
        
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let campaign = responseData.campaign {
                        self.campaign = campaign // Aggiorna instanza modello camapgna
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
    }
    
    func deleteCampaign(usrToken: String, campaignId: Int) {
        let url = apiUrl + "/campaigns/" + String(campaignId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        loading = true
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 200 {
                        self.deleted = true
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
                
                self.loading = false
            }
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
    
    func insertComment(usrToken: String, campaignId: Int, body: String) { // Aggiunge commento
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
                        self.comments.append(comment) // Aggiunge nuovo commento alla lista
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func editComment(usrToken: String, commentId: Int, body: String) { // Modifica commento
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
                                self.comments[index] = comment // Sostuisce commento con commento modificato
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
    
    func deleteComment(usrToken: String, commentId: Int) { // Elimina commento
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
                        self.comments.removeAll { $0.id == commentId } // Rimuove commento dalla lista
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func deletePicture(usrToken: String, pictureId: Int) { // Elimina immagine campagna
        let url = apiUrl + "/campaign-pictures/" + String(pictureId)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: CampaignPictureResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 200 {
                        self.pictures.removeAll { $0.id == pictureId } // Elimina immagine dalla lista
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
