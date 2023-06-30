//
//  User.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/05/23.
//

import Foundation
import SwiftUI
import Alamofire

let apiUrl = "https://aworldaction.zapto.org/api"

public class AppSettings: ObservableObject {
    @AppStorage("usrToken") var usrToken = "" //Token utente, AppStorage: persistente anche dopo riavvio app
    @Published var user: LoggedUser? // Instanza del modello dell'utente loggato
    @Published var requestFailed = false // Non è stato possibile verificare che l'accesso
    
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
                        self.usrToken = "" // Elimina user token se non più valido
                    }
                    
                    if let user = responseData.user {
                        self.user = user
                    }
                    
                    self.requestFailed = false
                    print(responseData)
                    
                case .failure(let error):
                    self.requestFailed = true // Non è possibile comunicare con il server
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
        // Richiama route logout sul server
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                
                case .success(let responseData):
                    self.usrToken = "" // Elimina token utente
                    self.requestFailed = false
                    print(responseData)
                
                case .failure(let error):
                    self.requestFailed = true
                    print(error)
                }
            }
    }
    
    func relateCampaign(campaignId: Int) {
        let url = apiUrl + "/relate-campaign/logged"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: usrToken),
            .accept("application/json")
        ]
        let body = [
            "campaign_id": campaignId
        ]
        // Relaziona una campagna all'utente loggato
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: [String: String].self) { response in
                switch response.result {
                
                case .success(let responseData):
                    print(responseData)
                
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getStorageUrl(path: String) -> URL? {
        let serverUrl = apiUrl.replacingOccurrences(of: "api", with: "storage") // Sostituisce il percorso /api con /storage
        let newUrl = path.replacingOccurrences(of: "public", with: serverUrl) // Sostituisce il percorso del file con quello remoto
        return URL(string: newUrl)
    }
    
    func formatDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Formato data che riceve
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMM yyyy, HH:mm" // Nuovo formato data
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    func getRoleName(roleId: Int) -> String {
        switch (roleId) {
        case 1:
            return StringComponents.userRole // Utente
        case 2:
            return StringComponents.adminRole // Admin
        default:
            return ""
        }
    }

}
