//
//  ActionBarView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 10/12/23.
//

import SwiftUI

struct ActionBarView: View {
    var backAction: (() -> Void)?
    var title: String
    var rounded = true
    
    var body: some View {
        ZStack {
            if let action = backAction {
                HStack {
                    Button(action: action, label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    })
                    Spacer()
                }
            }
            
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(
            ColorComponents.lightGreen
                .cornerRadius(
                    rounded ? 12 : 0,
                    corners: [.bottomLeft, .bottomRight]
                )
                .ignoresSafeArea()
        )
    }
}

#Preview {
    ActionBarView(backAction: {}, title: StringComponents.loginViewTitle)
}
