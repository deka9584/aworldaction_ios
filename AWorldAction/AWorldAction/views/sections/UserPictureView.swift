//
//  UserPictureView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 08/06/23.
//

import SwiftUI

struct UserPictureView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var path: String?
    @State var size: CGFloat
    
    var body: some View {
        if let path = path {
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
            .frame(width: size, height: size)
            .clipped()
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
        }
        
    }
}

struct UserPictureView_Previews: PreviewProvider {
    static var previews: some View {
        UserPictureView(size: 40)
    }
}
