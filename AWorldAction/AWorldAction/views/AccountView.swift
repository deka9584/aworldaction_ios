//
//  AccountView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 04/06/23.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Il tuo account")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .background(ColorComponents.lightGreen)
            
            HStack {
                Image(systemName: "person.circle")
                    .imageScale(.large)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text(appSettings.user?.name ?? "Utente")
                        .font(.body)
                    Text("Ruolo")
                        .font(.caption)
                        .textCase(.uppercase)
                }
                .padding(.horizontal, 4)
                // Text(appSettings.user?.name ?? "Utente")
                Spacer()
            }
            .padding()
            .background(ColorComponents.lightGray)
            .cornerRadius(12)
            .padding()
            
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
