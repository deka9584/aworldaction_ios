//
//  Components.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/04/23.
//

import Foundation
import SwiftUI

public class Components: ObservableObject {
    @Published var green = Color(red: 0.223, green: 0.710, blue: 0.290)
    @Published var lightGreen = Color(red: 0.549, green: 0.776, blue: 0.247)
    @Published var lightGray = Color(red: 233/255, green: 233/255, blue: 233/255)
    
    @Published var loginViewTitle = "Login"
    @Published var registerViewTitle = "Registrati"
    
    @Published var loginBtn = "Accedi"
    @Published var registerBtn = "Registrati"
    @Published var nextBtn = "Avanti"
    
    @Published var loginUserHint = "Username / E-Mail"
    @Published var loginPassHint = "Password"
    @Published var newUserHint = "Crea un nuovo username"
    @Published var emailHint = "Inserisci una e-mail"
    @Published var confirmPassHint = "Conferma password"
    
    @Published var passRecoveryLink = "Recupera password"
    @Published var loginLink = "Ho già un account"
    
    @Published var accountStep1 = "Inserisci i dati del tuo account"
    @Published var accountStep2 = "Crea una password sicura"
    @Published var accountStep3 = "Inserisci una foto profilo"
    
    @Published var showLoginView = false
    @Published var showRegisterView = false
}
