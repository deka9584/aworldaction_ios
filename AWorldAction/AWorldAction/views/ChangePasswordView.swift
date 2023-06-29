//
//  ChangePasswordView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 29/06/23.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var accountModel: AccountModel
    @State var currPass = ""
    @State var newPass = ""
    @State var newPassConfirm = ""
    
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
                Text("Cambia password")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            Spacer()
            
            VStack {
                SecureField("Password attuale", text: $currPass)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField("Nuova password", text: $newPass)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField("Conferma nuova password", text: $newPassConfirm)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    accountModel.changePassword(usrToken: appSettings.usrToken, currentPass: currPass, newPass: newPass, newPassConfirm: newPassConfirm)
                } label: {
                    ZStack {
                        if (accountModel.loading) {
                            ProgressView()
                        }
                        
                        Text("Cambia password")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(ColorComponents.lightGreen)
                            .foregroundColor(Color.white)
                            .cornerRadius(12)
                    }
                }
                .disabled(accountModel.loading)
                
                if (accountModel.message != "") {
                    Text(accountModel.message)
                        .foregroundColor(Color.red)
                        .textCase(Text.Case.uppercase)
                        .font(.caption)
                        .padding(.top)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .onChange(of: accountModel.changePasswordSuccess) { success in
            if (success) {
                close()
            }
        }
    }
    
    func close() {
        accountModel.showChangePass = false
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(accountModel: AccountModel())
    }
}
