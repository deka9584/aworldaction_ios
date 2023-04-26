//
//  Register2View.swift
//  AWorldAction
//
//  Created by Andrea Sala on 17/04/23.
//

import SwiftUI

struct Register2View: View {
    @ObservedObject var components: Components
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
                Text(components.registerViewTitle)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(components.lightGreen)
            
            Spacer()
            
            VStack {
                Text(components.accountStep2)
                    .font(.headline)
                    .padding(.bottom)
                
                SecureField(components.loginPassHint, text: $registerModel.passField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                SecureField(components.confirmPassHint, text: $registerModel.confirmPassField)
                    .textContentType(.password)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .padding(.horizontal)
                    .background(components.lightGray)
                    .cornerRadius(12)
                    .padding(.bottom)
                
                Button {
                    registerModel.submit()
                } label: {
                    Text(components.nextBtn)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(components.lightGreen)
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
        Register2View(components: Components(), registerModel: RegisterModel())
    }
}
