//
//  ListView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//


import SwiftUI

struct FavouritesView: View {
    
    static let tag: String? = "Favourites"
   
    @FetchRequest(entity: ImageEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ImageEntity.creationDate, ascending: true )], predicate: NSPredicate(format: "favourite = true")) var images: FetchedResults<ImageEntity>
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView  {
                LazyVGrid(columns: columns) {
                    ForEach(images) { image in
                       GridItemsView(image: image)
                   }
                    }
                    .padding()
                 }
                .navigationTitle("Favourites")
                .background(Color.systemGroupedBackground.ignoresSafeArea())
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
       
    }
}






/*
 func reset() {
     image = nil
     imageName = ""
     selectedImage = nil
 }
 */
