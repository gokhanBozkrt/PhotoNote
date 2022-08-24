//
//  FotoNotApp.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import SwiftUI

@main
struct FotoNotApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    var body: some Scene {
        WindowGroup {
           ListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)

                
        }
    }
}
