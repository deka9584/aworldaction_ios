//
//  UploadImageModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import Foundation
import Alamofire
import SwiftUI

public class UploadImageModel: ObservableObject {
    @Published var loading = false
    @Published var success = false
    @Published var message: String?
    
    func uploadImage(usrToken: String, image: UIImage, campaignId: Int, caption: String) {
        let url = apiUrl + "/campaign-pictures"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let parameters: [String: Any] = [
            "campaign_id": campaignId,
            "caption": caption,
        ]
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Errore nella conversione dell'immagine")
            return
        }
        
        loading = true
        
        AF.upload(
            multipartFormData: { multipartFormData in
                // Aggiungi i dati dell'immagine all'oggetto multipartFormData
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                
                for (key, value) in parameters {
                    if let data = "\(value)".data(using: .utf8) {
                        multipartFormData.append(data, withName: key)
                    }
                }
            },
            to: url,
            method: .post, // Imposta il metodo HTTP su POST
            headers: headers
        )
        .responseString() { response in
            switch response.result {
                
            case .success(let responseData):
                if response.response?.statusCode == 201 {
                    self.success = true
                    self.loading = false
                }
                
                print(responseData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
