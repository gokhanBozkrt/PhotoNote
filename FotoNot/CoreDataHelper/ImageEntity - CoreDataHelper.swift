//
//  ImageEntity - CoreDataHelper.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 19.08.2022.
//

import Foundation
import UIKit

extension ImageEntity {
    
    var imageName: String {
        name ?? ""
    }
    var imageRecordDate: String {
        "\(creationDate?.formatted() ??  "N/A")" 
    }
    var imageId: String {
        id?.uuidString ?? ""
    }
    var viewerImage: UIImage {
        if let data = image , let savedImage = UIImage(data: data) {
            return savedImage
        } else {
            return UIImage(systemName: "note.text")!
        }
    }
    
    
}
