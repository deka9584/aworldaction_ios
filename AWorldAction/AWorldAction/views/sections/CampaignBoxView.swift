//
//  CampaignListView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI
import Alamofire

struct CampaignBoxView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var campaign: Campaign
    @State var related = false
    @State var creator = false
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(
                url: appSettings.getStorageUrl(path: campaign.pictures?.first?.path ?? ""),
                content: {
                    image in image.resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    if (campaign.pictures?.isEmpty == true) {
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Text("Ancora nessuna immagine")
                            .padding()
                    } else {
                        ProgressView()
                    }
                }
            )
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
            .background(Color.gray)
            .foregroundColor(Color.white)
            .clipped()
            
            HStack {
                Text(campaign.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            .background(ColorComponents.green)
            .cornerRadius(24, corners: [.bottomRight])
            
            HStack {
                Text(campaign.description)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            
            HStack {
                NavigationLink("Maggiori informazioni", destination: DetailView(campaignId: campaign.id))
                    .padding(10)
                    .foregroundColor(Color.white)
                    .background(ColorComponents.green)
                    .cornerRadius(12)
                
                Spacer()
                
                if (creator) {
                    Image(systemName: (campaign.completed == 1) ? "heart.fill" : "heart")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                } else if (campaign.completed == 1) {
                    Image(systemName: related ? "heart.fill" : "checkmark")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                } else {
                    Button {
                        appSettings.relateCampaign(campaignId: campaign.id)
                        related.toggle()
                    } label: {
                        Image(systemName: related ? "star.fill" : "star")
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(ColorComponents.green)
                            .cornerRadius(12)
                    }
                }
                
                Button {
                    Utils.openMaps(lat: campaign.location_lat, lng: campaign.location_lng)
                } label: {
                    Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(ColorComponents.lightGreen)
        .cornerRadius(12)
        .padding()
        .onAppear() {
            related = (campaign.contributors?.contains { $0.id == appSettings.user?.id }) ?? false
            creator = (campaign.creator_id?.contains(appSettings.user?.id ?? 0)) ?? false
        }
    }
    
    
}
