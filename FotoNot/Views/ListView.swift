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
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView {
            ScrollView  {
                LazyVGrid(columns: columns) {
                    ForEach(images) { image in
                        VStack {
                            Image(uiImage: image.viewerImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                             //   .padding()
                            VStack(spacing: 10) {
                                Text(image.imageName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(image.imageRecordDate)
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.mint.opacity(0.6))
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                       RoundedRectangle(cornerRadius: 10)
                        .stroke(.mint.opacity(0.6))
                        )
                   }
                    }
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
