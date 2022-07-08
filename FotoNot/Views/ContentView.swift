//
//  ContentView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm : VieModel
    var body: some View {
        VStack {
                 Button("Start Tracking Location") {
                     vm.locations.start()
                 }

                 Button("Read Location") {
                     if let location = self.vm.locations.lastKnownLocation {
                         print("Your location is \(location)")
                     } else {
                         print("Your location is unknown")
                     }
                 }
             }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
