//
//  RegisterModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import Foundation
import Alamofire

public class RegisterModel: ObservableObject {
    @Published var userField = ""
    @Published var emailField = ""
    @Published var passField = ""
    @Published var confirmPassField = ""
    @Published var status = ""
    @Published var loading = false
    @Published var showChosePassword = false
    
    func nextStep() {
        if (userField != "" && emailField != "") {
            showChosePassword = true
        }
    }
    
    func sendRequest(appSettings: AppSettings) { // Richiesta di registrazione
        let url = apiUrl + "/signup"
        let headers: HTTPHeaders = [
            .accept("application/json")
        ]
        let body = [
            "name": userField,
            "email": emailField,
            "password": passField,
            "password_confirmation": confirmPassField
        ]
        
        loading = true
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    
                case .success(let responseData):
                    if (![200, 201].contains(response.response?.statusCode)) {
                        self.status = responseData.message ?? ""
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
                
                self.showChosePassword = false
                self.loading = false
            }
        
        resetFields()
    }
    
    func resetFields() {
        userField = ""
        emailField = ""
        passField = ""
        confirmPassField = ""
    }
}
