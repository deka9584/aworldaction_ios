//
//  WelcomeView.swift
//  AWorldAction
//
//  Created by Luca Virzí on 31/03/23.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var components: Components
    
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
                    components.showLoginView.toggle()
                } label: {
                    Text(components.loginBtn)
                        .frame(maxWidth: 220, minHeight:50)
                        .background(components.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
                
                Button {
                    components.showRegisterView.toggle()
                } label: {
                    Text(components.registerBtn)
                        .frame(maxWidth: 220, minHeight:50)
                        .background(components.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
            }
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $components.showLoginView, content: {
            LoginView(components: components)
        })
        .fullScreenCover(isPresented: $components.showRegisterView, content: {RegisterView(components: components)
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(components: Components())
    }
}
