//
//  FetchCampaignsError.swift
//  AWorldAction
//
//  Created by Andrea Sala on 08/06/23.
//

import SwiftUI

struct FetchCampaignsErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle.fill")
                .imageScale(.large)
                .foregroundColor(.red)
                .padding(.top)
            Text(StringComponents.campaignListFetchError)
                .padding(.top)
            Text(StringComponents.retryBtn)
                .padding(.top)
                .foregroundColor(Color.blue)
        }
        .padding()
    }
}

struct FetchCampaignsError_Previews: PreviewProvider {
    static var previews: some View {
        FetchCampaignsErrorView()
    }
}
