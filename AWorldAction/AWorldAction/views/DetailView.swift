//
//  DetailView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/06/23.
//

import SwiftUI

struct DetailView: View {
    let campaignId: Int
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignModel = CampaignModel()
    
    var body: some View {
        VStack {
            ScrollView {
                Text(campaignModel.campaign?.name ?? "Nome campagna")
                    .font(.title)
                    .padding()
                
                TabView {
                    ForEach(campaignModel.pictures) {picture in
                        AsyncImage(
                            url: picture.getUrl(),
                            content: {
                                image in image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .overlay() {
                                        VStack {
                                            Text(picture.caption)
                                                .font(.caption)
                                                .padding(8)
                                                .background(Color.black.opacity(0.6))
                                                .foregroundColor(Color.white)
                                                .cornerRadius(12)
                                                .padding(.top)
                                            Spacer()
                                        }
                                    }
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                .background(Color.gray)
                
                
                
                Text("Dettagli")
                    .font(.title2)
                    .padding(.top)
                
                VStack {
                    Text("Località")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .imageScale(.large)
                        Text(campaignModel.campaign?.location_name ?? "Località")
                    }
                    .padding(.top)
                    
                    Text("Descrizione")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    Text(campaignModel.campaign?.description ?? "Descrizione")
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Text("Stato campagna")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    HStack {
                        if (campaignModel.campaign?.completed == 1) {
                            Image(systemName: "checkmark.square.fill")
                                .imageScale(.large)
                            Text("Completata")
                        } else {
                            Image(systemName: "hourglass")
                                .imageScale(.large)
                            Text("In corso")
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(ColorComponents.lightGray)
                .cornerRadius(12)
                .padding()
            }
        }
        .onAppear() {
            if (campaignId != 0) {
                campaignModel.fetch(appSettings: appSettings, campaignId: campaignId)
            }
        }
        .overlay() {
            if (campaignModel.loading) {
                VStack {
                    ProgressView()
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(campaignId: 0)
    }
}
