//
//  DetailView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 06/06/23.
//

import SwiftUI
import CoreLocation

struct DetailView: View {
    let campaignId: Int
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var detailModel = DetailModel()
    @State var userComment = ""
    @State var deleteCommentConfirm = false
    @State var showEdit = false
    @State var editingComment: Comment?
    @State var showUpload = false
    @State var deleteCampaignConfirm = false
    
    var body: some View {
        VStack(spacing: 0) {
            ActionBarView(backAction: {
                presentationMode.wrappedValue.dismiss()
            }, title: detailModel.campaign?.name ?? "Nome campagna", rounded: false)
            
            ScrollView {
                CampaignCarouselView(detailModel: detailModel, showUpload: $showUpload)
                
                Text("Dettagli")
                    .font(.title2)
                    .padding(.top)
                
                VStack {
                    MapView(coordinate: CLLocationCoordinate2D(latitude: detailModel.campaign?.location_lat ?? 0, longitude: detailModel.campaign?.location_lng ?? 0))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .cornerRadius(12, corners: [.bottomRight, .bottomLeft])
                    
                    Text("Località")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .imageScale(.large)
                        Text(detailModel.campaign?.location_name ?? "Località")
                    }
                    .padding(.top)
                    
                    Text("Descrizione")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    Text(detailModel.campaign?.description ?? "Descrizione")
                        .padding(.horizontal)
                        .padding(.top)
                    
                    Text("Stato campagna")
                        .font(.title3)
                        .foregroundColor(ColorComponents.green)
                        .bold()
                        .padding(.top)
                    
                    HStack {
                        if (detailModel.campaign?.completed == 1) {
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
                    ForEach (detailModel.contributors) {
                        contributor in
                        HStack {
                            UserPictureView(path: contributor.picture_path, size: 40)
                            Text(contributor.name)
                                .padding()
                            Text(detailModel.campaign?.creator_id?.contains(contributor.id) ?? false ? "Creatore" : "Contributore")
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
                    UserPictureView(path: appSettings.user?.picture_path, size: 40)
                        .padding()
                    VStack(alignment: .leading) {
                        TextField("Il tuo commento", text: $userComment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button {
                            detailModel.insertComment(usrToken: appSettings.usrToken, campaignId: campaignId, body: userComment)
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
                    ForEach (detailModel.comments) {
                        comment in
                        HStack {
                            UserPictureView(path: comment.picture_path, size: 40)
                            VStack {
                                Text(comment.user_name)
                                    .padding(1)
                                Text(comment.body)
                                    .font(.caption)
                                    .padding(1)
                                
                                if (comment.created_at != comment.updated_at) {
                                    Text("Modificato")
                                        .font(.caption)
                                        .foregroundColor(Color.gray)
                                        .padding(1)
                                }
                            }
                            .padding(.horizontal)
                            
                            if (appSettings.user?.id == comment.user_id) {
                                Button {
                                    editingComment = comment
                                    showEdit = true
                                } label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(Color.orange)
                                }
                                
                                Button(role: .destructive) {
                                    editingComment = comment
                                    deleteCommentConfirm = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(Color.red)
                                }
                                .confirmationDialog("Vuoi eliminare il commento", isPresented: $deleteCommentConfirm) {
                                    Button("Elimina", role: .destructive) {
                                        if let commentId = editingComment?.id {
                                            detailModel.deleteComment(usrToken: appSettings.usrToken, commentId: commentId)
                                            editingComment = nil
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(ColorComponents.lightGray)
                        .cornerRadius(12)
                    }
                }
                .padding(.bottom)
                
                VStack {
                    Button {
                        guard let lat = detailModel.campaign?.location_lat else { return }
                        guard let lng = detailModel.campaign?.location_lng else { return }
                        Utils.openMaps(lat: lat, lng: lng)
                    } label: {
                        Text("Visualizza in Mappe")
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    if (isCreatorLogged()) {
                        Button(action: {
                            var newStatus = detailModel.campaign?.completed != 1
                            detailModel.update(usrToken: appSettings.usrToken, campaignId: campaignId, campaignStatus: newStatus)
                        }, label: {
                            if (detailModel.campaign?.completed == 1) {
                                Text("Contrassegna come ancora in corso")
                                    .padding(10)
                                    .foregroundColor(Color.white)
                                    .background(Color.orange)
                                    .cornerRadius(12)
                            } else {
                                Text("Contrassegna come completata")
                                    .padding(10)
                                    .foregroundColor(Color.white)
                                    .background(ColorComponents.green)
                                    .cornerRadius(12)
                            }
                        })
                        
                        Button(role: .destructive) {
                            deleteCampaignConfirm = true
                        } label: {
                            Text("Elimina campagna")
                                .padding(10)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                        .confirmationDialog("Vuoi eliminare la campagna?", isPresented: $deleteCampaignConfirm) {
                            Button("Elimina", role: .destructive) {
                                detailModel.deleteCampaign(usrToken: appSettings.usrToken, campaignId: campaignId)
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            .refreshable(action: {
                loadCampaign()
            })
        }
        .onAppear() {
            loadCampaign()
        }
        .overlay() {
            if (detailModel.loading) {
                ProgressView()
            }
        }
        .fullScreenCover(isPresented: $showUpload, content: {
            UploadImageView(campaignId: campaignId, showUpload: $showUpload)
        })
        .fullScreenCover(isPresented: $showEdit, content: {
            EditCommentView(campaignModel: detailModel, showEdit: $showEdit, editingComment: $editingComment)
        })
        .onChange(of: detailModel.deleted) { deleted in
            if (deleted) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: showUpload) { showUpload in
            if (!showUpload) {
                loadCampaign()
            }
        }
    }
    
    func loadCampaign() {
        if (campaignId != 0) {
            detailModel.fetch(usrToken: appSettings.usrToken, campaignId: campaignId)
        }
    }
    
    func isCreatorLogged() -> Bool {
        return detailModel.campaign?.creator_id?.contains(appSettings.user?.id ?? 0) ?? false
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(campaignId: 0)
            .environmentObject(AppSettings())
    }
}
