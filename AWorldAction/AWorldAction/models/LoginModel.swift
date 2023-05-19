//
//  LoginModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 07/04/23.
//

import Foundation
import Alamofire

public class LoginModel: ObservableObject {
    @Published var userField = ""
    @Published var passField = ""
    
    func submit(appSettings: AppSettings) {
        sendRequest(appSettings: appSettings)
        userField = ""
        passField = ""
    }
    
    func sendRequest(appSettings: AppSettings) {
        let url = apiUrl + "/login"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
        ]
        let body = [
            "email": userField,
            "password": passField
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    case .success(let responseData):
                    appSettings.usrToken = responseData.token
                    appSettings.user = responseData.user
                    
                    case .failure(let error):
                    // Gestisci l'errore
                    print(error)
                    }
            }
    }
}
