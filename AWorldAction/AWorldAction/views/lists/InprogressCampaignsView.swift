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
                    if (!cListModel.campaignList.isEmpty) {
                        ForEach(cListModel.campaignList) {
                            campaign in
                            CampaignBoxView(campaign: campaign)
                        }
                    } else if (cListModel.loading) {
                        ProgressView()
                            .padding()
                    } else if (cListModel.failed) {
                        FetchCampaignsErrorView()
                            .onTapGesture {
                                refresh()
                            }
                    } else {
                        Text(StringComponents.campaignListEmpty)
                            .padding(.top)
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
    }
    
    func refresh() {
        cListModel.loadCampaigns(appSettings: appSettings)
    }
}
