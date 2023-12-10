//
//  LoginView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/04/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var loginModel = LoginModel()
    
    var body: some View {
        VStack {
            ActionBarView(backAction: {
                presentationMode.wrappedValue.dismiss()
            }, title: StringComponents.loginViewTitle)
            
            Spacer()
            
            VStack {
                TextField(StringComponents.loginUserHint, text: $loginModel.emailField)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
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
                            .bold()
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
                
                NavigationLink(destination: {
                    RegisterView()
                }, label: {
                    Text(StringComponents.loginLink)
                        .foregroundColor(.blue)
                })
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
