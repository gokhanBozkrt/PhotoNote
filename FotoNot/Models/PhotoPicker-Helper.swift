//
//  PhotoPicker-Helper.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 30.08.2022.
//

import AVFoundation
import Foundation
import SwiftUI

enum PickerModel {
    enum Source {
        case library,camera
    }
    enum PickerError: Error,LocalizedError {
        case unavaliable,restricted,denied
        var errorDescription: String? {
            switch self {
            case .unavaliable:
                return NSLocalizedString("Bu cihazda kamera bulunmamaktadır", comment: " ")
            case .restricted:
                return NSLocalizedString("Kamera kullanımına izini bulunmamaktadır", comment: " ")

            case .denied:
                return NSLocalizedString("Kamera kullanım iznini kısıtlamışsınız. Lütfen izinlerden kamera erişimini açın.", comment: " ")

            }
        }
    }
    
    static func checkPermissions() throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .restricted:
                throw PickerError.restricted
            case .denied:
                throw PickerError.denied
            default:
                break
            }
        } else {
            throw PickerError.unavaliable
       }
    }
    struct CameraErrorType {
        let error:PickerModel.PickerError
        var  message: String {
            error.localizedDescription
        }
        let button = Button("OK",role: .cancel) { }
    }
    
}

