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
    @State private var userComment = ""
    @State var deleteCommentConfirm: Bool = false
    
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
                                .foregroundColor(ColorComponents.green)
                            Text(StringComponents.statusCompleted)
                                .bold()
                                .foregroundColor(ColorComponents.green)
                        } else {
                            Image(systemName: "hourglass")
                                .imageScale(.large)
                                .foregroundColor(Color.orange)
                            Text(StringComponents.statusInprogress)
                                .bold()
                                .foregroundColor(Color.orange)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(ColorComponents.lightGray)
                .cornerRadius(12)
                .padding()
                
                Text("Partecipanti")
                    .font(.title2)
                    .padding(.top)
                
                VStack(spacing: 20) {
                    ForEach (campaignModel.contributors) {
                        contributor in
                        HStack {
                            UserPictureView(path: contributor.picture_path, size: 40)
                            Text(contributor.name)
                                .padding()
                            Text(campaignModel.campaign?.creator_id?.contains(contributor.id) ?? false ? "Creatore" : "Contributore")
                                .textCase(.uppercase)
                                .font(.caption)
                        }
                        .padding()
                        .background(ColorComponents.lightGray)
                        .cornerRadius(12)
                    }
                }
                .padding()
                
                Text("Commenti")
                    .font(.title2)
                    .padding(.top)
                
                HStack {
                    UserPictureView(path: appSettings.user?.picure_path, size: 40)
                        .padding()
                    VStack(alignment: .leading) {
                        TextField("Il tuo commento", text: $userComment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            campaignModel.insertComment(usrToken: appSettings.usrToken, campaignId: campaignId, body: userComment)
                            userComment = ""
                        } label: {
                            Text("Commenta")
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(ColorComponents.lightGreen)
                                .foregroundColor(Color.white)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
                .background(ColorComponents.lightGray)
                .cornerRadius(12)
                .padding()
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach (campaignModel.comments) {
                        comment in
                        HStack {
                            UserPictureView(path: comment.picture_path, size: 40)
                            VStack {
                                Text(comment.user_name)
                                    .padding(1)
                                Text(comment.body)
                                    .font(.caption)
                                    .padding(1)
                            }
                            .padding(.horizontal)
                            
                            if (appSettings.user?.id == comment.user_id) {
                                Button {
                                    deleteCommentConfirm = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(Color.red)
                                }
                                .confirmationDialog("Vuoi eliminare il comment", isPresented: $deleteCommentConfirm) {
                                    Button("Elimina", role: .destructive) {
                                        campaignModel.deleteComment(usrToken: appSettings.usrToken, comment: comment)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(ColorComponents.lightGray)
                        .cornerRadius(12)
                    }
                }
            }
        }
        .onAppear() {
            if (campaignId != 0) {
                campaignModel.fetch(usrToken: appSettings.usrToken, campaignId: campaignId)
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
