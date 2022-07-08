//
//  ImageError.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import Foundation
import SwiftUI

enum ImageError: Error,LocalizedError {
    case readError,decodingError,encodingError,saveError,saveImageError,readImageError,deleteImageError
    
    var  errorDescription: String? {
        switch self {
        case .readError:
            return NSLocalizedString("Dosya yüklenemedi lütfen tekrar deneyin", comment: "")
        case .decodingError:
            return NSLocalizedString("Dosya okunamadı lütfen tekrar deneyin", comment: "")
        case .encodingError:
            return NSLocalizedString("Dosya kayıt edilemedi lütfen tekrar deneyin", comment: "")
        case .saveError:
            return NSLocalizedString("Dosya kayıt edilemedi lütfen tekrar deneyin", comment: "")
        case .saveImageError:
            return NSLocalizedString("Resim kayıt edilemedi lütfen tekrar deneyin", comment: "")
        case .readImageError:
            return NSLocalizedString("Resim açılmıyor lütfen tekrar deneyin", comment: "")
        case .deleteImageError:
            return NSLocalizedString("Resim silinemedi lütfen tekrar deneyin", comment: "")

        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: ImageError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK",role: .cancel) { }
    }
}
