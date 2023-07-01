//
//  AccountView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/06/23.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var accountModel = AccountModel()
    @State var removePictureConfirm = false
    @State var logoutConfirm = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                ScrollView {
                    HStack {
                        ZStack {
                            if let path = appSettings.user?.picture_path {
                                AsyncImage(
                                    url: appSettings.getStorageUrl(path: path),
                                    content: {
                                        image in image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                .frame(width: 80, height: 80)
                                .clipped()
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                            }
                        }
                        .onTapGesture {
                            accountModel.showPictUpload = true
                        }
                        VStack(alignment: .leading) {
                            Text(appSettings.user?.name ?? "Utente")
                                .font(.body)
                                .padding(.bottom, 1)
                            Text(appSettings.getRoleName(roleId: appSettings.user?.role_id ?? 0))
                                .font(.caption)
                                .textCase(.uppercase)
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding()
                    
                    VStack {
                        if (accountModel.message != "") {
                            Text(accountModel.message)
                                .foregroundColor(.red)
                                .font(.caption)
                                .textCase(.uppercase)
                                .padding()
                        }
                        
                        Button {
                            accountModel.showChangePass = true
                        } label: {
                            Text("Cambia password")
                                .bold()
                                .textCase(.uppercase)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(12)
                        }
                        
                        Button(role: .destructive) {
                            removePictureConfirm = true
                        } label: {
                            Text("Rimuovi immage profilo")
                                .bold()
                                .textCase(.uppercase)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(12)
                        }
                        .confirmationDialog("Vuoi rimuovere la tua immagine profilo?", isPresented: $removePictureConfirm) {
                            Button("Rimuovi", role: .destructive) {
                                accountModel.deleteImage(usrToken: appSettings.usrToken)
                            }
                        }
                        
                        Button(role: .destructive) {
                            logoutConfirm = true
                        } label: {
                            Text(StringComponents.logoutBtn)
                                .bold()
                                .textCase(.uppercase)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                        .confirmationDialog("Vuoi uscire dal tuo account?", isPresented: $logoutConfirm) {
                            Button("Esci", role: .destructive) {
                                appSettings.logout()
                            }
                        }
                    }
                }
                .navigationTitle("Il tuo account")
            }
        }
        .onAppear() {
            accountModel.message = ""
        }
        .fullScreenCover(isPresented: $accountModel.showPictUpload) {
            UploadProfilePictView(accountModel: accountModel)
        }
        .fullScreenCover(isPresented: $accountModel.showChangePass, content: {
            ChangePasswordView(accountModel: accountModel)
        })
    }
}
