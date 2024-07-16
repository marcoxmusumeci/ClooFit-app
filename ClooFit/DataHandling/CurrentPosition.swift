//
//  CurrentPosition.swift
//  ClooFit
//
//  Created by Paolo Sortino on 10/07/24.
//

import Foundation
import CoreLocation
import Combine

class CurrentPosition: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
        private let geocoder = CLGeocoder()
        
        @Published var location: CLLocation? {
            willSet { objectWillChange.send() }
        }
        
        @Published var city: String? {
            willSet { objectWillChange.send() }
        }
        
        override init() {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            self.location = location
            reverseGeocode(location: location)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
        }
        
        private func reverseGeocode(location: CLLocation) {
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Error in reverse geocoding: \(error.localizedDescription)")
                    self.city = "Errore nella geocodifica"
                    return
                }
                
                if let placemark = placemarks?.first {
                    self.city = placemark.locality ?? "Città non trovata"
                }
            }
        }
}
