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
                if (appSettings.requestFailed) {
                    ConnectionErrorView()
                } else {
                    HomeView() // Utente loggato
                }
            } else {
                WelcomeView() // Utente non loggato
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
