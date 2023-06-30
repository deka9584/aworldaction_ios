//
//  UploadImageView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import SwiftUI

struct UploadImageView: View {
    let campaignId: Int
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var uploadImageModel = UploadImageModel()
    @Binding var showUpload: Bool
    @State var userCaption = ""
    @State var showPicker = false
    @State var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    Button {
                        close()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                }
                Text(StringComponents.uploadImage)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .clipped()
                } else {
                    VStack {
                        Spacer()
                        
                        Button {
                            showPicker = true
                        } label: {
                            HStack {
                                Image(systemName: "photo")
                                Text("Scegli una foto")
                            }
                            .padding()
                        }
                        
                        Spacer()
                    }
                }
                
                Text("Descrizione")
                    .font(.title2)
                    .padding(.top)
                
                TextField("Descrizione", text: $userCaption)
                    .keyboardType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
            }
            .padding()
            
            Spacer()
            
            if uploadImageModel.message != "" {
                Text(uploadImageModel.message)
                    .foregroundColor(Color.green)
                    .padding()
            }
            
            Button {
                if let image = selectedImage {
                    uploadImageModel.uploadImage(usrToken: appSettings.usrToken, image: image, campaignId: campaignId, caption: userCaption)
                }
            } label: {
                Text(StringComponents.uploadImage)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ColorComponents.green)
                    .cornerRadius(12)
            }
            .disabled(selectedImage == nil || userCaption == "" || uploadImageModel.loading)
            .opacity(selectedImage == nil || userCaption == "" || uploadImageModel.loading ? 0.8 : 1)
        }
        .fullScreenCover(isPresented: $showPicker, content: {
            ImagePickerView(sourceType: .photoLibrary, image: $selectedImage, isPresented: $showPicker)
        })
        .onChange(of: uploadImageModel.success) { success in
            if (success) {
                close()
            }
        }
        .overlay() {
            if (uploadImageModel.loading) {
                ProgressView()
            }
        }
    }
    
    func close() {
        showUpload = false
    }
}
