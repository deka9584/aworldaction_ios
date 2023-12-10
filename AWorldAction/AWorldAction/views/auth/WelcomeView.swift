//
//  WelcomeView.swift
//  AWorldAction
//
//  Created by Luca Virzí on 31/03/23.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 220)
                    .padding()
                
                Spacer()
                    
                VStack {
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            Text(StringComponents.loginBtn)
                                .frame(maxWidth: 220, minHeight:50)
                                .background(ColorComponents.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(12)
                        }
                    )
                    
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text(StringComponents.registerBtn)
                                .frame(maxWidth: 220, minHeight:50)
                                .background(ColorComponents.lightGreen)
                                .foregroundColor(Color.white)
                                .cornerRadius(12)
                        }
                    )
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
