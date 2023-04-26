//
//  LoginView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/04/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var components: Components
    @ObservedObject var loginModel = LoginModel()
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        components.showLoginView = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                Text(components.loginViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(components.lightGreen)
            
            Spacer()
            
            VStack {
                TextField(components.loginUserHint, text: $loginModel.userField)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField(components.loginPassHint, text: $loginModel.passField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    loginModel.submit()
                } label: {
                    Text(components.loginBtn)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(components.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                VStack(spacing: 14) {
                    Button {
                        //Show password recovery
                    } label: {
                        Text(components.passRecoveryLink)
                    }
                    
                    Button {
                        components.showLoginView = false
                        components.showRegisterView = true
                    } label: {
                        Text(components.registerBtn)
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
        LoginView(components: Components())
    }
}
