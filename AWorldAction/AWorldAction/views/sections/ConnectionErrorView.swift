//
//  ConnectionErrorView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 01/07/23.
//

import SwiftUI

struct ConnectionErrorView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                .imageScale(.large)
            Text(StringComponents.tokenVerificationError)
                .padding()
            Button {
                appSettings.checkAuth()
            } label: {
                Text(StringComponents.retryBtn)
            }
        }
    }
}

struct ConnectionErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionErrorView()
    }
}
