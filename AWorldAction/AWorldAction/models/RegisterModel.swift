//
//  RegisterModel.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import Foundation

public class RegisterModel: ObservableObject {
    @Published var userField = ""
    @Published var emailField = ""
    @Published var passField = ""
    @Published var confirmPassField = ""
    @Published var showChosePassword = false
    @Published var showChosePicture = false
    
    func submit() {
        if (showChosePassword) {
            if (passField != "" && passField == confirmPassField) {
                showChosePicture = true
            }
        } else {
            if (userField != "" && emailField != "") {
                showChosePassword = true
            }
        }
    }
}
