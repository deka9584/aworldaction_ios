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
    @State var isPresentingConfirm: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                ScrollView {
                    HStack {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(appSettings.user?.name ?? "Utente")
                                .font(.body)
                            Text(appSettings.getRoleName(roleId: appSettings.user?.role_id ?? 0))
                                .font(.caption)
                                .textCase(.uppercase)
                        }
                        .padding(.horizontal, 4)
                        Spacer()
                    }
                    .padding()
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding()
                    
                    HStack {
                        Button(role: .destructive) {
                            isPresentingConfirm = true
                        } label: {
                            Text(StringComponents.logoutBtn)
                                .bold()
                                .textCase(.uppercase)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                        .confirmationDialog("Vuoi uscire dal tuo account?", isPresented: $isPresentingConfirm) {
                            Button("Esci", role: .destructive) {
                                appSettings.logout()
                            }
                        }
                    }
                }
                .navigationTitle("Il tuo account")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
