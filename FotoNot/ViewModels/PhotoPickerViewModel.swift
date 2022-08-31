//
//  PhotoPickerViewModel.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 24.08.2022.
//

import Foundation

extension PhotoPickerView {
@MainActor class ViewModel: ObservableObject {
        @Published var source: PickerModel.Source = .library
        @Published var cameraError: PickerModel.CameraErrorType?
        @Published var showCameraAlert = false
        @Published var showPicker = false
        func showPhotoPicker() {
            do {
                if source == .camera {
                    try PickerModel.checkPermissions()
                    showPicker = true
                    
                }
              
            } catch  {
                showCameraAlert = true
                cameraError = PickerModel.CameraErrorType(error: error as! PickerModel.PickerError)
            }
        }
        
    }
}
