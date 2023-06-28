//
//  UploadImageView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import SwiftUI

struct UploadImageView: View {
    @Binding var showUpload: Bool
    @State var userCaption = ""
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    Button {
                        close()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                }
                Text(StringComponents.uploadImage)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            VStack {
                Button {
                    
                } label: {
                    Text("Scatta una foto")
                }
                
                Text("Descrizione")
                    .font(.title2)
                    .padding(.top)
                
                TextField("Descrizione", text: $userCaption)
                    .keyboardType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
            }
            .padding()
            
            Spacer()
            
            Button {
                
            } label: {
                Text(StringComponents.uploadImage)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ColorComponents.green)
                    .cornerRadius(12)
            }
        }
    }
    
    func close() {
        showUpload = false
    }
}

//struct UploadImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadImageView()
//    }
//}
