//
//  AccountModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 20/06/23.
//

import Foundation
import Alamofire
import SwiftUI

public class AccountModel: ObservableObject {
    @Published var showPictUpload = false
    @Published var showChangePass = false
    @Published var loading = false
    @Published var uploadSuccess = false
    @Published var changePasswordSuccess = false
    @Published var message = ""
    
    func uploadImage(usrToken: String, image: UIImage) { // Aggiorna immagine profilo
        let url = apiUrl + "/loggeduser/picture"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        // Comprime immagine (max: 512K)
        guard let imageData = Utils.compressImage(image, maxSizeInMB: 0.5) else {
            print("Errore nella conversione dell'immagine")
            return
        }
        
        loading = true
        uploadSuccess = false
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            },
            to: url,
            method: .post,
            headers: headers
        )
        .responseString() { response in
            switch response.result {
                
            case .success(let responseData):
                if [200, 201].contains(response.response?.statusCode) {
                    self.uploadSuccess = true
                }
                
                print(responseData)
                
            case .failure(let error):
                print(error)
            }
            
            if (!self.uploadSuccess) {
                self.message = "Impossibile aggiornare l'immagine"
            }
            
            self.loading = false
        }
    }
    
    func deleteImage(usrToken: String) {
        let url = apiUrl + "/loggeduser/picture"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        loading = true
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if let message = responseData.message {
                        self.message = message
                    }
                    
                    print(responseData)
                    
                case .failure(let error):
                    self.message = "Errore durante la rimozione dell'immagine"
                    print(error)
                }
                
                self.loading = false
            }
    }
    
    func changePassword(usrToken: String, currentPass: String, newPass: String, newPassConfirm: String) { // Cambio password
        let url = apiUrl + "/loggeduser/changepassword"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let body = [
            "current_password": currentPass,
            "password": newPass,
            "password_confirmation": newPassConfirm
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if response.response?.statusCode == 200 {
                        self.changePasswordSuccess = true
                        self.message = ""
                    } else {
                        if let message = responseData.message {
                            self.message = "Impossibile cambiare la password:" + message
                        }
                    }
                    
                case .failure(let error):
                    self.message = "Errore aggiornamento password"
                    print(error)
                }
            }
    }
}
