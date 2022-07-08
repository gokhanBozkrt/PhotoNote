//
//  FotoNotApp.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import SwiftUI

@main
struct FotoNotApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView()
           ListView()
                .environmentObject(VieModel())
        }
    }
}
