//
//  CreateCampaignView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import SwiftUI
import CoreLocation

struct CreateCampaignView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var createCampaignModel = CreateCampaignModel()
    @State var title = ""
    @State var description = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ActionBarView(backAction: {
                presentationMode.wrappedValue.dismiss()
            }, title: StringComponents.createCamlaign)
            
            ScrollView {
                if (createCampaignModel.success) {
                    Spacer()
                    
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorComponents.lightGreen)
                            .padding()
                        
                        Text(StringComponents.campaignCreated1)
                            .padding(.top)
                        
                        Text(StringComponents.campaignCreated2)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Chiudi")
                                .foregroundColor(Color.white)
                                .padding()
                                .background(ColorComponents.green)
                                .cornerRadius(12)
                        }
                    }
                    
                    Spacer()
                } else {
                    VStack {
                        Text("Titolo")
                            .font(.title2)
                            .textCase(.uppercase)
                            .bold()
                            .foregroundColor(Color.gray)
                            .padding(.top)
                        
                        TextField("Titolo della campagna", text: $title)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .padding(.horizontal)
                            .background(ColorComponents.lightGray)
                            .cornerRadius(12)
                            .padding(.bottom)
                        
                        Text("Descrizione")
                            .font(.title2)
                            .textCase(.uppercase)
                            .bold()
                            .foregroundColor(Color.gray)
                        
                        TextField("Aggiungi una descrizione", text: $description)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .padding(.horizontal)
                            .background(ColorComponents.lightGray)
                            .cornerRadius(12)
                            .padding(.bottom)
                        
                        Text("Luogo")
                            .font(.title2)
                            .textCase(.uppercase)
                            .bold()
                            .foregroundColor(Color.gray)
                        
                        MapView(coordinate: locationManager.currentLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: .infinity, height: 280)
                            .cornerRadius(12)
                        
                        HStack {
                            if let locality = locationManager.currentLocality {
                                Image(systemName: "location.fill")
                                Text(locality)
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            
            Spacer()
            
            if let message = createCampaignModel.message {
                Text(message)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button {
                submit()
            } label: {
                Text(StringComponents.createCamlaign)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(ColorComponents.green)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .overlay() {
            if (createCampaignModel.loading) {
                ProgressView()
            }
        }
        .onChange(of: createCampaignModel.success) { success in
            if (success) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func submit() {
        if let location = locationManager.currentLocation {
            let locality = locationManager.currentLocality ?? "Unknown place"
            
            createCampaignModel.postCampaign(usrToken: appSettings.usrToken, name: title, description: description, locality: locality, location: location)
        }
    }
}

#Preview {
    CreateCampaignView()
        .environmentObject(AppSettings())
}
