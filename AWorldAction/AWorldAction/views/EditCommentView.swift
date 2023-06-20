//
//  EditCommentView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 20/06/23.
//

import SwiftUI

struct EditCommentView: View {
    @EnvironmentObject var appSettings: AppSettings
    @StateObject var campaignModel: CampaignModel
    @Binding var showEdit: Bool
    @Binding var editingComment: Comment?
    @State var userText = ""
    
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
                Text(StringComponents.editComment)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            Spacer()
            
            HStack {
                UserPictureView(path: appSettings.user?.picture_path, size: 40)
                VStack {
                    HStack {
                        Text(appSettings.user?.name ?? "")
                            .padding(1)
                        Spacer()
                    }
                    
                    TextField("", text: $userText)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding(.horizontal)
                        .background(ColorComponents.lightGray)
                        .cornerRadius(12)
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
            
            Button {
                if let comment = editingComment {
                    campaignModel.editComment(usrToken: appSettings.usrToken, commentId: comment.id, body: userText)
                    close()
                }
            } label: {
                Text("Modifica commento")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ColorComponents.green)
                    .cornerRadius(12)
            }
            .padding()
        }
        .onAppear() {
            userText = editingComment?.body ?? ""
        }
    }
    
    func close() {
        editingComment = nil
        showEdit = false
    }
}
