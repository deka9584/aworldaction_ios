//
//  FetchCampaignsError.swift
//  AWorldAction
//
//  Created by Andrea Sala on 08/06/23.
//

import SwiftUI

struct CampaignLoadErrorView: View {
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle.fill")
                .imageScale(.large)
                .foregroundColor(.red)
                .padding(.top)
            
            Text(StringComponents.campaignListFetchError)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction, label: {
                Text(StringComponents.retryBtn)
            })
            .padding(.top)
        }
        .padding()
    }
}

struct FetchCampaignsError_Previews: PreviewProvider {
    static var previews: some View {
        CampaignLoadErrorView(retryAction: {})
    }
}
