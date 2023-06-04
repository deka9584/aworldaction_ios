//
//  LoginView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/04/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var welcomeModel: WelcomeModel
    @ObservedObject var loginModel = LoginModel()
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        welcomeModel.showLoginView = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                Text(StringComponents.loginViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            Spacer()
            
            VStack {
                TextField(StringComponents.loginUserHint, text: $loginModel.emailField)
                    .textContentType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField(StringComponents.loginPassHint, text: $loginModel.passField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    loginModel.sendRequest(appSettings: appSettings)
                } label: {
                    ZStack {
                        if (loginModel.loading) {
                            ProgressView()
                        }
                        
                        Text(StringComponents.loginBtn)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(ColorComponents.lightGreen)
                            .foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                }
                .disabled(loginModel.loading)
                
                if (loginModel.status != "") {
                    Text(loginModel.status)
                        .foregroundColor(Color.red)
                        .textCase(Text.Case.uppercase)
                        .font(.caption)
                        .padding(.top)
                }
                
                VStack(spacing: 14) {
                    Button {
                        //Show password recovery
                    } label: {
                        Text(StringComponents.passRecoveryLink)
                    }
                    
                    Button {
                        welcomeModel.showLoginView = false
                        welcomeModel.showRegisterView = true
                    } label: {
                        Text(StringComponents.registerBtn)
                    }
                }
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(welcomeModel: WelcomeModel())
    }
}
