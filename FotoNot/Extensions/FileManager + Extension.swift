//
//  FileManager + Extension.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import Foundation
import UIKit

let fileName = "FotoNotes.json"

extension FileManager {
    static var docDirUrl: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func docExist(_ docName: String) -> Bool {
        fileExists(atPath: Self.docDirUrl.appendingPathComponent(docName).path)
    }
    
    func saveDocument(contents: String) throws {
        let url = Self.docDirUrl.appendingPathComponent(fileName)
        do {
            try contents.write(to: url,atomically: true, encoding: .utf8)
        } catch {
            throw ImageError.saveError
        }
    }
    
    func readDocument() throws -> Data {
        let url = Self.docDirUrl.appendingPathComponent(fileName)
        do {
         return try Data(contentsOf: url)
        } catch  {
            throw ImageError.readError
        }
    }
    
    func saveImage(_ id:UUID, image: UIImage) throws {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let imageUrl = Self.docDirUrl.appendingPathComponent("\(id).jpeg")
            do {
                try data.write(to: imageUrl)
            } catch  {
                throw ImageError.saveImageError
            }
        }
  }
    
    func readImage(with id: UUID) throws -> UIImage {
        let imageUrl = Self.docDirUrl.appendingPathComponent("\(id).jpeg")
        do {
          let imageData = try Data(contentsOf: imageUrl)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                throw ImageError.readImageError
            }
        } catch  {
            throw ImageError.readImageError
        }
    }
    
    func deleteImage(_ id: UUID) {
        let imageUrl = Self.docDirUrl.appendingPathComponent("\(id).jpeg")
        do {
            try removeItem(at: imageUrl)
        } catch  {
          ImageError.deleteImageError
        }
    }
    
}
