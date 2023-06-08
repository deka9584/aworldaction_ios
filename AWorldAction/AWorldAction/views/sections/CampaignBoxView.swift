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
                
                Button {
                    //
                } label: {
                    Image(systemName: "star")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                }
                
                Button {
                    //
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
    }
    
    
}
