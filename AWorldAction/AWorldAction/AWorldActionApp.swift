//
//  AWorldActionApp.swift
//  AWorldAction
//
//  Created by Luca Virzí on 30/03/23.
//

import SwiftUI

@main
struct AWorldActionApp: App {
    @StateObject var appSettings = AppSettings() // EnvironmentObject
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
        }
    }
}
