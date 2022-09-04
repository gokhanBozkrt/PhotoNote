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
    @StateObject var locationManager = LocationFetcher()
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    var body: some Scene {
        WindowGroup {
           ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(locationManager)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)

                
        }
    }
    func save(_ note: Notification) {
        dataController.save()
    }
}
