//
//  CampaignCarouselView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import SwiftUI

struct CampaignCarouselView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var detailModel: DetailModel
    @Binding var showUpload: Bool
    @State var deletePictureConfirm = false
    @State var editingPicutureId: Int?
    
    var body: some View {
        TabView {
            ForEach(detailModel.pictures) { picture in
                ZStack {
                    AsyncImage(
                        url: picture.getUrl(),
                        content: {
                            image in image.resizable()
                                .aspectRatio(contentMode: .fill)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                    .clipped()
                    
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
                    
                    VStack {
                        if (picture.user_id == appSettings.user?.id) {
                            HStack {
                                Spacer()
                                
                                Button {
                                    deletePictureConfirm = true
                                    editingPicutureId = picture.id
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.white)
                                        .padding(8)
                                        .background(Color.black.opacity(6))
                                        .cornerRadius(12)
                                        .padding()
                                }
                                .confirmationDialog("Vuoi eliminare l'immagine?", isPresented: $deletePictureConfirm) {
                                    Button("Elimina", role: .destructive) {
                                        if let pictureId = editingPicutureId {
                                            detailModel.deletePicture(usrToken: appSettings.usrToken, pictureId: pictureId)
                                            editingPicutureId = nil
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            
            Button {
                showUpload = true
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
    }
}
