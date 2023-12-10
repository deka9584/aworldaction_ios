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
    @State var showCreate = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ActionBarView(title: "Campagne in corso")
                
                ScrollView {
                    NavigationLink(destination: CreateCampaignView(), label: {
                        HStack {
                            Image(systemName: "location.circle.fill")
                                .imageScale(.large)
                                .padding()
                            Text("Pubblica nuova campagna")
                                .font(.title2)
                        }
                        .padding(1)
                        .frame(maxWidth: .infinity)
                        .background(ColorComponents.lightGray)
                        .cornerRadius(12)
                    })
                    .padding()
                    
                    ForEach(cListModel.campaignList) {
                        campaign in
                        CampaignBoxView(campaign: campaign)
                    }
                    
                    if (cListModel.failed) {
                        CampaignLoadErrorView(retryAction: {
                            refresh()
                        })
                    } else if (cListModel.campaignList.isEmpty) {
                        Text(StringComponents.campaignListEmpty)
                            .padding(.top)
                    }
                }
                .refreshable {
                    refresh()
                }
            }
        }
        .onAppear() {
            refresh()
        }
        .onChange(of: showCreate) { showCreateStatus in
            if (!showCreateStatus) {
                refresh()
            }
        }
        .overlay() {
            if (cListModel.loading) {
                ProgressView()
            }
        }
    }
    
    var createCampaignBtn: some View {
        Button {
            showCreate = true
        } label: {
            HStack {
                Image(systemName: "location.circle.fill")
                    .imageScale(.large)
                    .padding()
                Text("Pubblica nuova campagna")
                    .font(.title2)
            }
            .padding(1)
            .frame(maxWidth: .infinity)
            .background(ColorComponents.lightGray)
            .cornerRadius(12)
        }
        .padding()
    }
    
    func refresh() {
        cListModel.loadCampaigns(usrToken: appSettings.usrToken)
    }
}

#Preview {
    InprogressCampaignsView(cListModel: CampaignListModel(toShow: "inprogress"))
        .environmentObject(AppSettings())
}
