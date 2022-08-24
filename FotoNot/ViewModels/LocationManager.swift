//
//  LocationManager.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 5.06.2022.
//
import CoreLocation
import Foundation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate {
   
    static let example = LocationFetcher() 
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32 , longitude: 32) , span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        
        mapRegion = MKCoordinateRegion(center: lastKnownLocation!, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    }
    

}


/*
 
 class LocationFetcher: NSObject, CLLocationManagerDelegate {
     let manager = CLLocationManager()
     var lastKnownLocation: CLLocationCoordinate2D?

     override init() {
         super.init()
         manager.delegate = self
     }

     func start() {
         manager.requestWhenInUseAuthorization()
         manager.startUpdatingLocation()
     }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         lastKnownLocation = locations.first?.coordinate
     }
 }
 */


/*
 func checkLocationAuthorization() {
     guard let locationManager = locationManager else { return }

     switch locationManager.authorizationStatus {
         
     case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
     case .restricted:
         print("Your location is restricted")
     case .denied:
         print("Your location is restricted go to settings turn it on")
     case .authorizedAlways, .authorizedWhenInUse:
         region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 32, longitude: locationManager.location?.coordinate.longitude ?? 39), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
     @unknown default:
         break
     }
 }
 
 func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
     checkLocationAuthorization()
 }
 */
