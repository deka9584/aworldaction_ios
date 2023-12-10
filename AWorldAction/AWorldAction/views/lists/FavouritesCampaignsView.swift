//
//  FavouritesCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 05/06/23.
//

import SwiftUI

struct FavouritesCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var cListModel = CampaignListModel(toShow: "favourites")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ActionBarView(title: "Campagne completate")
                
                ScrollView {
                    if (cListModel.loading) {
                        ProgressView()
                            .padding()
                    }
                    
                    ForEach(cListModel.campaignList) {
                        campaign in
                        CampaignBoxView(campaign: campaign)
                    }
                    
                    if (cListModel.failed) {
                        CampaignLoadErrorView(retryAction: {
                            refresh()
                        })
                    } else if (cListModel.campaignList.isEmpty) {
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorComponents.green)
                            .padding(.top)
                        Text(StringComponents.favouritesEmpty)
                            .padding(.top)
                    }
                }
                .refreshable {
                    refresh()
                }
            }
        }
        .onAppear() {
            refresh()
        }
    }
    
    func refresh() {
        cListModel.loadCampaigns(usrToken: appSettings.usrToken)
    }
}

struct FavouritesCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesCampaignsView()
            .environmentObject(AppSettings())
    }
}
