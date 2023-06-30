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
    @Published var message = ""
    
    func uploadImage(usrToken: String, image: UIImage, campaignId: Int, caption: String) { // Caricamento immagine campagna
        let url = apiUrl + "/campaign-pictures"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let parameters: [String: Any] = [
            "campaign_id": campaignId,
            "caption": caption,
        ]
        
        guard let imageData = Utils.compressImage(image, maxSizeInBytes: 2 * 1024 * 1024) else {
            print("Errore nella conversione dell'immagine")
            return
        }
        
        loading = true
        
        AF.upload(
            multipartFormData: { multipartFormData in
                // Aggiunge i dati dell'immagine
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                // Aggiunge paramentri aggiuntivi (campaign_id, caption)
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
                } else if response.response?.statusCode == 401 {
                    self.message = "Non sei autorizzato"
                } else {
                    self.message = "Immagine non accettata dal server"
                }
                
                print(responseData)
                
            case .failure(let error):
                self.message = "Errore durante il caricamento dell'immagine"
                print(error)
            }
        }
    }
}
