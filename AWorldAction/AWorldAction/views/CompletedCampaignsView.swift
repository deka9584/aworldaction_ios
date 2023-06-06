//
//  CompletedCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 05/06/23.
//

import SwiftUI

struct CompletedCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var cListModel = CampaignListModel(toShow: "completed")
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                ScrollView {
                    if (cListModel.failed) {
                        Text(StringComponents.campaignListFetchError)
                        
                        Button {
                            refresh()
                        } label: {
                            Text(StringComponents.retryBtn)
                        }
                    } else {
                        ForEach(cListModel.campaignList) {
                            campaign in
                            CampaignBoxView(campaign: campaign)
                        }
                    }
                }
                .navigationTitle("Campagne completate")
                .refreshable {
                    refresh()
                }
            }
        }
        .onAppear() {
            refresh()
        }
        .overlay() {
            if (cListModel.loading) {
                VStack {
                    ProgressView()
                }
            }
        }
    }
    
    func refresh() {
        cListModel.loadCampaigns(appSettings: appSettings)
    }
}

struct CompletedCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedCampaignsView()
    }
}
