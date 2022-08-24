//
//  PhotoPickerViewModel.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 24.08.2022.
//

import Foundation

extension PhotoPickerView {
    class ViewModel: ObservableObject {
        @Published var source: Picker.Source = .library
        @Published var cameraError: Picker.CameraErrorType?
        @Published var showCameraAlert = false
        @Published var showPicker = false
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
        
    }
}
