//
//  CampaignListView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 03/06/23.
//

import SwiftUI

struct CampaignBoxView: View {
    @State var campaign: Campaign
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(
                url: URL(string: "https://via.placeholder.com/640x480.png/0044dd?text=animals+et"),
                content: {
                    image in image.resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    ProgressView()
                }
            )
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
            .clipped()
            HStack {
                Text(campaign.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            .background(ColorComponents.green)
            .cornerRadius(24, corners: [.bottomRight])
            HStack {
                Text(campaign.description)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            HStack {
                Button {
                    //
                } label: {
                    Text("Maggiori informazioni")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                }
                Spacer()
                Button {
                    //
                } label: {
                    Image(systemName: "star")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                }
                Button {
                    //
                } label: {
                    Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                        .padding(10)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(ColorComponents.lightGreen)
        .cornerRadius(12)
        .padding()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
