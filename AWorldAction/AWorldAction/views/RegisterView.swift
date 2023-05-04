//
//  RegisterView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var welcomeModel: WelcomeModel
    @ObservedObject var registerModel = RegisterModel()
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        welcomeModel.showRegisterView = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                Text(StringComponents.registerViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            Spacer()
            
            VStack {
                Text(StringComponents.accountStep1)
                    .font(.headline)
                    .padding(.bottom)
                
                TextField(StringComponents.newUserHint, text: $registerModel.userField)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                TextField(StringComponents.emailHint, text: $registerModel.emailField)
                    .textContentType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    registerModel.submit()
                } label: {
                    Text(StringComponents.nextBtn)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(ColorComponents.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                VStack(spacing: 14) {
                    Button {
                        welcomeModel.showRegisterView = false
                        welcomeModel.showLoginView = true
                    } label: {
                        Text(StringComponents.loginLink)
                    }
                }
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
        }
        .fullScreenCover(isPresented: $registerModel.showChosePassword, content: {
            Register2View(registerModel: registerModel)
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(welcomeModel: WelcomeModel())
    }
}
