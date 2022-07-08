//
//  ListView- ViewModel.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

class VieModel: ObservableObject {
    @Published var myImages = [ImageModel]()
    @Published var image: UIImage?
    
    @Published var showPicker = false
    @Published var source : Picker.Source = .library
    
    @Published var cameraError: Picker.CameraErrorType?
    @Published var showCameraAlert = false
    
    @Published var showFileAlert = false
    @Published var appError: ImageError.ErrorType?
    
    @Published var imageName = ""
    @Published var selectedImage: ImageModel?

   @Published var locations = LocationFetcher()


  

    
    
    // MARK: Reset to save new image
    
    func reset() {
        image = nil
        imageName = ""
        selectedImage = nil
    }
    
    // MARK: Camera Checker
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
                showPicker = true
            }
          
        } catch  {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    // MARK: Add Image to Doc Direc...
    func addImage(_ name: String, image: UIImage) {
        let newImage = ImageModel(name: name, latitude: locations.lastKnownLocation?.latitude ?? 39, longitude: locations.lastKnownLocation?.longitude ?? 32)
        do {
            try FileManager().saveImage(newImage.id, image: image)
            myImages.append(newImage)
            saveImageJsonFile()
        
        } catch  {
            showFileAlert = true
            appError = ImageError.ErrorType(error: error as! ImageError)
        }
        
        withAnimation {
        reset()
        }
    }
    
    // MARK: To save Docs to Json File
    
    func saveImageJsonFile() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(myImages) else {
          showFileAlert = true
            appError = ImageError.ErrorType(error: .encodingError)
            return
        }
        guard let jsonString = try? String(decoding: data, as: UTF8.self) else {
            return
        }

        do {
            try FileManager().saveDocument(contents: jsonString)
        } catch  {
            showFileAlert = true
            appError = ImageError.ErrorType(error: error as! ImageError)
        }
        reset()
    }

    func loadImageJsonFile() {
        do {
            let data = try FileManager().readDocument()
            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode([ImageModel].self, from: data)
                self.myImages = imageData
            } catch  {
                showFileAlert = true
                appError = ImageError.ErrorType(error: .decodingError)
            }
        } catch  {
            showFileAlert = true
            appError = ImageError.ErrorType(error: error as! ImageError)
        }
    }
    
//  MARK: Wikipedia Api
     enum LoadingState {
        case loading, loaded,failed
    }
    
    
    /*
     func fetchNearbyPlaces() async {
         let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
         guard let url = URL(string: urlString) else {
             print("Bad URL: \(urlString)")
             return
         }
         do {
             let (data, _) = try await URLSession.shared.data(from: url)
             let  items = try JSONDecoder().decode(Result.self, from: data)
             self.pages = items.query.pages.values.sorted()
             loadingState = .loaded
             
         } catch {
             loadingState = .failed
         }
     }
     */
    
}


