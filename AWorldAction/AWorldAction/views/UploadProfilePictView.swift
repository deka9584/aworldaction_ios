//
//  UploadProfilePictView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import SwiftUI

struct UploadProfilePictView: View {
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var accountModel: AccountModel
    @State var showPicker = false
    @State var newImage: UIImage?
    
    var body: some View {
        VStack {
            ActionBarView(backAction: {
                close()
            }, title: "Carica immagine", rounded: false)
            
            Spacer()
            
            VStack {
                if let image = newImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .padding()
                } else {
                    Button {
                        
                    } label: {
                        Button {
                            showPicker = true
                        } label: {
                            HStack {
                                Image(systemName: "photo")
                                Text("Scegli una foto")
                            }
                            .padding()
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                if let image = newImage {
                    accountModel.uploadImage(usrToken: appSettings.usrToken, image: image)
                }
            } label: {
                Text(StringComponents.uploadImage)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ColorComponents.green)
                    .cornerRadius(12)
            }
            .disabled(newImage == nil)
            .opacity(newImage == nil ? 0.8 : 1)
        }
        .fullScreenCover(isPresented: $showPicker, content: {
            ImagePickerView(sourceType: .photoLibrary, image: $newImage, isPresented: $showPicker)
        })
        .onChange(of: accountModel.loading) { loading in
            if (!loading) {
                close()
                appSettings.checkAuth()
            }
        }
    }
    
    func close() {
        accountModel.showPictUpload = false
    }
}

struct UploadProfilePictView_Previews: PreviewProvider {
    static var previews: some View {
        UploadProfilePictView(accountModel: AccountModel())
    }
}
