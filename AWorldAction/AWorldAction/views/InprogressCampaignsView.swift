//
//  InprogressCampaignsView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct InprogressCampaignsView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Campagne in corso")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .background(ColorComponents.lightGreen)
            
            ScrollView {
                CampaignListView()
            }
            
            Spacer()
        }
    }
}

struct InprogressCampaignsView_Previews: PreviewProvider {
    static var previews: some View {
        InprogressCampaignsView()
    }
}
