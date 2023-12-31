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
                .navigationTitle("Campagne completate")
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

struct CompletedCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedCampaignsView()
    }
}
