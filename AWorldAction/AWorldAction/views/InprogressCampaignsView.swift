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
                    ForEach(cListModel.campaignList) {
                        campaign in
                        CampaignBoxView(campaign: campaign)
                    }
                }
                .navigationTitle("Campagne in corso")
                .refreshable {
                    cListModel.loadCampaigns(appSettings: appSettings)
                }
            }
        }
        .onAppear() {
            cListModel.loadCampaigns(appSettings: appSettings)
        }
        .overlay() {
            if (cListModel.loading) {
                VStack {
                    ProgressView()
                }
            }
        }
    }
}
