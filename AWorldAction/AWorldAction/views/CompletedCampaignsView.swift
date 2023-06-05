//
//  CompletedCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 05/06/23.
//

import SwiftUI

struct CompletedCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignList = CampaignListModel(toShow: "completed")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Campagne completate")
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

struct CompletedCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedCampaignsView()
    }
}
