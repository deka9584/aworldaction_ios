//
//  RegisterView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var registerModel = RegisterModel()
    
    var body: some View {
        VStack {
            ActionBarView(backAction: {
                presentationMode.wrappedValue.dismiss()
            }, title: StringComponents.registerViewTitle)
            
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
                    .keyboardType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    registerModel.nextStep()
                } label: {
                    Text(StringComponents.nextBtn)
                        .bold()
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(ColorComponents.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                if (registerModel.status != "") {
                    Text(registerModel.status)
                        .foregroundColor(Color.red)
                        .textCase(Text.Case.uppercase)
                        .font(.caption)
                        .padding(.top)
                }
                
                NavigationLink(destination: {
                    LoginView()
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
        .navigationDestination(isPresented: $registerModel.showChosePassword, destination: {
            Register2View(registerModel: registerModel)
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
