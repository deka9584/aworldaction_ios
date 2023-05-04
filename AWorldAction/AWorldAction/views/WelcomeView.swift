//
//  WelcomeView.swift
//  AWorldAction
//
//  Created by Luca Virzí on 31/03/23.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var model = WelcomeModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 220)
                .padding()
            
            Spacer()
                
            VStack {
                Button {
                    model.showLoginView.toggle()
                } label: {
                    Text(StringComponents.loginBtn)
                        .frame(maxWidth: 220, minHeight:50)
                        .background(ColorComponents.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                Button {
                    model.showRegisterView.toggle()
                } label: {
                    Text(StringComponents.registerBtn)
                        .frame(maxWidth: 220, minHeight:50)
                        .background(ColorComponents.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $model.showLoginView, content: {
            LoginView(welcomeModel: model)
        })
        .fullScreenCover(isPresented: $model.showRegisterView, content: {
            RegisterView(welcomeModel: model)
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
