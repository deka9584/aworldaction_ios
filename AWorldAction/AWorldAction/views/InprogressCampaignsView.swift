//
//  InprogressCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct InprogressCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignsModel = CampaignsModel()
    
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
                ForEach(campaignsModel.campaignList) {
                    campaign in
                    CampaignBoxView(campaign: campaign)
                }
            }
            
            Spacer()
        }
        .onAppear() {
            campaignsModel.loadCampaigns(appSettings: appSettings)
        }
        .overlay() {
            if (campaignsModel.loading) {
                VStack {
                    ProgressView()
                }
            }
        }
    }
}
