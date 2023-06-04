//
//  HomeView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        TabView {
            InprogressCampaignsView()
                .tabItem {
                    Image(systemName: "hourglass.circle")
                    Text("Campagne")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
