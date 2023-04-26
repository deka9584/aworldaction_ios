//
//  LoginModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 07/04/23.
//

import Foundation

public class LoginModel: ObservableObject {
    @Published var userField = ""
    @Published var passField = ""
    
    func submit() {
        userField = ""
        passField = ""
    }
}
