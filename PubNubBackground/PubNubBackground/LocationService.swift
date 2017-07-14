//
//  LocationService.swift
//  PubNubBackground
//
//  Created by Jordan Zucker on 7/14/17.
//  Copyright © 2017 PubNub. All rights reserved.
//

import UIKit
import CoreLocation

class LocationService: NSObject {
    
    let locationManager: CLLocationManager
    
    static let shared = LocationService()
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }
    
    func startUpActions() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            startTrackingLocation()
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
        default:
            fatalError("Case not handled")
        }
    }
    
    func startTrackingLocation() {
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.desiredAccuracy = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
    }

}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            startTrackingLocation()
        case .notDetermined:
            print("Not determined yet!")
        default:
            fatalError("Case not handled")
        }
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("\(#function)")
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print("\(#function)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(#function)")
    }
    
}
