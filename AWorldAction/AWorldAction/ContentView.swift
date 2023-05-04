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
        if (showWelcomeView) {
            WelcomeView()
        } else if (showHomeView) {
            Text("home view")
        } else {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 240)
                    .padding()
                
                ProgressView()
                    .padding(.top)
            }
            .padding()
            .onAppear() {
                if (appSettings.usrToken == "") {
                    showWelcomeView = true
                } else {
                    showHomeView = true
                }
                // Verify user token
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
