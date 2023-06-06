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
                ForEach(cListModel.campaignList) {
                    campaign in
                    CampaignBoxView(campaign: campaign)
                }
            }
            
            Spacer()
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

struct FavouritesCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesCampaignsView()
    }
}
