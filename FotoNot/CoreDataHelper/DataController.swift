//
//  DataController.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 19.08.2022.
//
import CoreData
import Foundation
import UIKit

class DataController: ObservableObject {
    let container: NSPersistentContainer
    let containerName = "ImageModel"
    
    init(inMemory: Bool = false) {
       container = NSPersistentContainer(name: containerName)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { sortDescriptor, error in
            if let error = error {
                fatalError("Fatal error loading store \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController =  {
        let dataController = DataController(inMemory: true)
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        return dataController
    }()
    
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        let savedImage = ImageEntity(context: viewContext)
        savedImage.id = UUID()
        savedImage.name = "Gokhan"
        savedImage.latitude = 39.941959
        savedImage.longitude = 32.8077479
        savedImage.creationDate = Date()
        guard let image = UIImage(named: "ExampleImage") else {
            return
        }
        savedImage.image = image.jpegData(compressionQuality: 0.8)
        try viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ImageEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? container.viewContext.execute(batchDeleteRequest)
    }
    
    
}
