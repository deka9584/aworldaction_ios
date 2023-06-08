//
//  User.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/05/23.
//

import Foundation
import SwiftUI
import Alamofire

let apiUrl = "http://127.0.0.1:8000/api"

public class AppSettings: ObservableObject {
    @AppStorage("usrToken") var usrToken = ""
    @Published var user: LoggedUser?
    @Published var requestFailed = false
    
    func checkAuth() {
        let url = apiUrl + "/loggeduser"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    case .success(let responseData):
                    if response.response?.statusCode != 200 {
                        self.usrToken = ""
                    }
                    
                    if let user = responseData.user {
                        self.user = user
                    }
                    
                    self.requestFailed = false
                    print(responseData)
                    
                    case .failure(let error):
                    self.requestFailed = true
                    print(error)
                }
            }
    }
    
    func logout() {
        let url = apiUrl + "/logout"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                    case .success(let responseData):
                    self.usrToken = ""
                    print(responseData)
                    
                    case .failure(let error):
                    self.requestFailed = true
                    print(error)
                }
            }
    }
    
    func getStorageUrl(path: String) -> URL? {
        let serverUrl = apiUrl.replacingOccurrences(of: "api", with: "storage")
        let newUrl = path.replacingOccurrences(of: "public", with: serverUrl)
        return URL(string: newUrl)
    }
}
