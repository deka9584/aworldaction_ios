//
//  LoginModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 07/04/23.
//

import Foundation
import Alamofire

public class LoginModel: ObservableObject {
    @Published var emailField = ""
    @Published var passField = ""
    @Published var status = ""
    @Published var loading = false
    
    func sendRequest(appSettings: AppSettings) { // Richiesta Login
        let url = apiUrl + "/login"
        let headers: HTTPHeaders = [
            .accept("application/json")
        ]
        let body = [
            "email": emailField,
            "password": passField
        ]
        
        loading = true
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if (![200, 201].contains(response.response?.statusCode)) { // Se status non è 200 o 201 visualizza messaggio di errore
                        self.status = responseData.message ?? "Error"
                    }
                    
                    if let token = responseData.token {
                        appSettings.usrToken = token // Salva token su appSettings
                    }
                        
                    if let user = responseData.user {
                        appSettings.user = user // Salva instanza modello user
                    }
                    
                case .failure(let error):
                    print(error)
                    self.status = StringComponents.loginError // Errore di comunicazione con il server
                }
                
                self.loading = false
            }
        
        resetFields()
    }
    
    func resetFields() {
        emailField = ""
        passField = ""
        status = ""
    }
}
