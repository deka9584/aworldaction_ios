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
                Text("Sei loggato")
                    .font(.title)
                Text(appSettings.user?.name ?? "")
            } else {
                WelcomeView()
            }
        }
        .onAppear() {
            appSettings.checkAuth()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
