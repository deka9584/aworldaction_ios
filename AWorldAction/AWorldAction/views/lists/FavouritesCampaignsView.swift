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
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorComponents.green)
                            .padding(.top)
                        Text(StringComponents.favouritesEmpty)
                            .padding(.top)
                    }
                }
                .navigationTitle("Preferiti")
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

struct FavouritesCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesCampaignsView()
    }
}
