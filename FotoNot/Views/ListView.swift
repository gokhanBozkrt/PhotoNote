//
//  ListView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//


import SwiftUI

struct ListView: View {
    @State private var showPhotoPicker = false
    @FetchRequest(sortDescriptors: []) private var images: FetchedResults<ImageEntity>
 
    var body: some View {
        NavigationView {
            VStack(alignment: .leading)  {
                 List  {
                        ForEach(images) { image in
                                HStack {
                                    Image(uiImage: image.viewerImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 44, height: 44)
                                  Text(image.imageName)
                            }
                           

    
                    }
                 }.listStyle(.inset)
                  
            }
            .navigationTitle("Foto Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showPhotoPicker = true
                    } label: {
                    Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPickerView()
            }
      
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
       
    }
}






/*
 func reset() {
     image = nil
     imageName = ""
     selectedImage = nil
 }
 */
