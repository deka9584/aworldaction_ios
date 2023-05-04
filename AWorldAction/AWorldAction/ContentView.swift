//
//  ContentView.swift
//  AWorldAction
//
//  Created by Luca Virzí on 30/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var loaded = false
    
    var body: some View {
        if (loaded) {
            WelcomeView()
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
                self.loaded = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
