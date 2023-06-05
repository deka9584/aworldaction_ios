//
//  InprogressCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct InprogressCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignList = CampaignListModel(toShow: "inprogress")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Campagne in corso")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .background(ColorComponents.lightGreen)
            
            ScrollView {
                ForEach(campaignList.campaignList) {
                    campaign in
                    CampaignBoxView(campaign: campaign)
                }
            }
            
            Spacer()
        }
        .onAppear() {
            campaignList.loadCampaigns(appSettings: appSettings)
        }
        .overlay() {
            if (campaignList.loading) {
                VStack {
                    ProgressView()
                }
            }
        }
    }
}
