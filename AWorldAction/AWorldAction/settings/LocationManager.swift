//
//  LocationManager.swift
//  AWorldAction
//
//  Created by Andrea Sala on 28/06/23.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentLocality: String?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Errore nel reverse geocoding: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                if let locality = placemark.locality {
                    self.currentLocality = locality
                }
            }
        }
    }
}
