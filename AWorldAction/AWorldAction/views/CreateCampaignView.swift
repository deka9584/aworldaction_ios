//
//  CreateCampaignView.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import SwiftUI
import CoreLocation

struct CreateCampaignView: View {
    @EnvironmentObject var appSettings: AppSettings
    @Binding var showCreate: Bool
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var createCampaignModel = CreateCampaignModel()
    @State var title = ""
    @State var description = ""
    
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
                Text(StringComponents.createCamlaign)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(ColorComponents.lightGreen)
            
            if (createCampaignModel.success) {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(ColorComponents.lightGreen)
                        .padding()
                    
                    Text("Campagna creata correttamente")
                        .padding()
                    
                    Button {
                        close()
                    } label: {
                        Text("Chiudi")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(ColorComponents.green)
                            .cornerRadius(12)
                    }
                }
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
                        .cornerRadius(24, corners: [.topLeft, .bottomRight])
                }
                .padding()
                
                Spacer()
                
                Button {
                    submit()
                } label: {
                    Text(StringComponents.createCamlaign)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(ColorComponents.green)
                        .cornerRadius(12)
                }
            }
        }
        .overlay() {
            if (createCampaignModel.loading) {
                ProgressView()
            }
        }
    }
    
    func submit() {
        if let location = locationManager.currentLocation {
            let locality = locationManager.currentLocality ?? "Unknown place"
            
            createCampaignModel.postCampaign(usrToken: appSettings.usrToken, name: title, description: description, locality: locality, location: location)
        }
    }
    
    func close() {
        showCreate = false
    }
    
}
