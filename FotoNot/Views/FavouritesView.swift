//
//  ListView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//


import SwiftUI

struct FavouritesView: View {
    
    static let tag: String? = "Favourites"
    @State private var showPhotoPicker = false
    @FetchRequest(entity: ImageEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ImageEntity.creationDate, ascending: true )], predicate: NSPredicate(format: "favourite = true")) var images: FetchedResults<ImageEntity>
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView  {
                LazyVGrid(columns: columns) {
                    ForEach(images) { image in
                        LazyVStack {
                            Image(uiImage: image.viewerImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                            
                            VStack(spacing: 10) {
                                Text(image.imageName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(image.imageRecordDate)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .shadow(radius: 25)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.gray.opacity(0.6))
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                       RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(0.3))
                        )
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
