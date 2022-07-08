//
//  ImageModel.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//
import CoreLocation
import Foundation
import SwiftUI
import UIKit

struct ImageModel: Identifiable,Codable,Comparable,Equatable {
    var id = UUID()
    var name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var image: UIImage {
        do {
            let myImage =  try  FileManager().readImage(with: id)
            return myImage
        } catch  {
            return UIImage(systemName: "photo.fill")!
        }
        
    }
    
    static func < (lhs: ImageModel, rhs: ImageModel) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
        lhs.id == rhs.id
    }
    
}


/*
 let latitude: Double
 let longitude: Double
 var coordinate: CLLocationCoordinate2D {
     CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
 }
 */
