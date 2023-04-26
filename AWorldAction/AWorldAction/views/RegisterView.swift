//
//  RegisterView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var components: Components
    @ObservedObject var registerModel = RegisterModel()
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        components.showRegisterView = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                Text(components.registerViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(components.lightGreen)
            
            Spacer()
            
            VStack {
                Text(components.accountStep1)
                    .font(.headline)
                    .padding(.bottom)
                
                TextField(components.newUserHint, text: $registerModel.userField)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                TextField(components.emailHint, text: $registerModel.emailField)
                    .textContentType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    registerModel.submit()
                } label: {
                    Text(components.nextBtn)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(components.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                VStack(spacing: 14) {
                    Button {
                        components.showRegisterView = false
                        components.showLoginView = true
                    } label: {
                        Text(components.loginLink)
                    }
                }
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
        }
        .fullScreenCover(isPresented: $registerModel.showChosePassword, content: {
            Register2View(components: components, registerModel: registerModel)
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(components: Components())
    }
}
