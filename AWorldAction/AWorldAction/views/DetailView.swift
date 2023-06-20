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
    @State var deleteCommentConfirm = false
    @State var showEdit = false
    @State var editingComment: Comment?
    
    var body: some View {
        VStack {
            ScrollView {
                Text(campaignModel.campaign?.name ?? "Nome campagna")
                    .font(.title)
                    .padding()
                
                TabView {
                    ForEach(campaignModel.pictures) { picture in
                        AsyncImage(
                            url: picture.getUrl(),
                            content: {
                                image in image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .overlay() {
                                        VStack {
                                            VStack {
                                                Text(picture.caption)
                                                    .font(.caption)
                                                    .foregroundColor(Color.white)
                                                
                                                Text(appSettings.formatDateString(dateString: picture.created_at))
                                                    .font(.caption)
                                                    .foregroundColor(Color.gray)
                                                
                                            }
                                            .padding(8)
                                            .background(Color.black.opacity(0.6))
                                            .cornerRadius(12)
                                            .padding(.top)
                                            
                                            Spacer()
                                        }
                                        .padding(1)
                                    }
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                    
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .padding()
                                .foregroundColor(Color.white)
                            
                            Text("Pubblica un aggiornamento")
                                .font(.title2)
                                .foregroundColor(Color.white)
                        }
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
                    UserPictureView(path: appSettings.user?.picture_path, size: 40)
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
                                
                                Button {
                                    editingComment = comment
                                    deleteCommentConfirm = true
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(Color.red)
                                }
                                .confirmationDialog("Vuoi eliminare il comment", isPresented: $deleteCommentConfirm) {
                                    Button("Elimina", role: .destructive) {
                                        if let commentId = editingComment?.id {
                                            campaignModel.deleteComment(usrToken: appSettings.usrToken, commentId: commentId)
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
        .fullScreenCover(isPresented: $showEdit, content: {
            EditCommentView(campaignModel: campaignModel ,showEdit: $showEdit, editingComment: $editingComment)
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(campaignId: 0)
    }
}
