//
//  Register2View.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import SwiftUI

struct Register2View: View {
    @ObservedObject var registerModel: RegisterModel
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Button {
                        registerModel.showChosePassword = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                Text(StringComponents.registerViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            Spacer()
            
            VStack {
                Text(StringComponents.accountStep2)
                    .font(.headline)
                    .padding(.bottom)
                
                SecureField(StringComponents.loginPassHint, text: $registerModel.passField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField(StringComponents.confirmPassHint, text: $registerModel.confirmPassField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(ColorComponents.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    registerModel.submit()
                } label: {
                    Text(StringComponents.nextBtn)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(ColorComponents.lightGreen)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

struct Register2View_Previews: PreviewProvider {
    static var previews: some View {
        Register2View(registerModel: RegisterModel())
    }
}
