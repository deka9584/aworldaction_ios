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
        VStack(spacing: 0) {
            NavigationView {
                ScrollView {
                    if (!cListModel.campaignList.isEmpty) {
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
                        Button {
                            showCreate = true
                        } label: {
                            HStack {
                                Image(systemName: "location.circle.fill")
                                    .imageScale(.large)
                                    .padding()
                                Text("Crea la prima campagna")
                                    .font(.title2)
                            }
                            .padding(1)
                            .frame(maxWidth: .infinity)
                            .background(ColorComponents.lightGray)
                            .cornerRadius(12)
                        }
                        .padding()
                        
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
        .fullScreenCover(isPresented: $showCreate, content: {
            CreateCampaignView(showCreate: $showCreate)
        })
    }
    
    func refresh() {
        cListModel.loadCampaigns(appSettings: appSettings)
    }
}
