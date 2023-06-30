//
//  ContentView.swift
//  AWorldAction
//
//  Created by Luca Virzí on 30/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var showWelcomeView = false
    @State var showHomeView = false
    
    var body: some View {
        VStack {
            if (appSettings.usrToken != "") {
                if (appSettings.requestFailed) { // Errore di comunicazione con il server
                    Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                        .imageScale(.large)
                    Text(StringComponents.tokenVerificationError)
                        .padding()
                    Button {
                        appSettings.checkAuth()
                    } label: {
                        Text(StringComponents.retryBtn)
                    }
                } else {
                    HomeView() // Se loggato mostra home view
                }
            } else {
                WelcomeView() // Se non loggato mostra accedi / registrati
            }
        }
        .onAppear() {
            appSettings.checkAuth() // Controlla che il token sia valido
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
