//
//  FavouritesCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 05/06/23.
//

import SwiftUI

struct FavouritesCampaignsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignList = CampaignListModel(toShow: "favourites")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Preferiti")
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

struct FavouritesCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesCampaignsView()
    }
}
