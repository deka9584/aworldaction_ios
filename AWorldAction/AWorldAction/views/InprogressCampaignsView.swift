//
//  InprogressCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct InprogressCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var cListModel = CampaignListModel(toShow: "inprogress")
    
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
                .navigationTitle("Campagne in corso")
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
