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
    
    func sendRequest(appSettings: AppSettings) {
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
                    if ([200, 201].contains(response.response?.statusCode)) {
                        self.status = responseData.message ?? "Error"
                    }
                    
                    if let token = responseData.token {
                        appSettings.usrToken = token
                    }
                        
                    if let user = responseData.user {
                        appSettings.user = user
                    }
                    
                case .failure(let error):
                    print(error)
                    self.status = StringComponents.loginError
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
