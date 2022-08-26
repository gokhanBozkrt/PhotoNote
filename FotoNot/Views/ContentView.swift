//
//  ContentView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 26.08.2022.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            FavouritesView()
                .tag(FavouritesView.tag)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favaurites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
