//
//  ListView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 3.06.2022.
//

import SwiftUI

struct ListView: View {
    @State private var showPhotoPicker = false
    @State private var showMap = false
   @EnvironmentObject var vm : VieModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading)  {
                 List  {
                        ForEach(vm.myImages.sorted()) { image in
                            NavigationLink {
                                PhotoDetailScreen(image: image.image, title: image.name)
                            } label: {
                                HStack {
                                Image(uiImage: image.image)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 44, height: 44)
                                  
                                Text(image.name)
                            }
                            }

    
                    }
                 }.listStyle(.inset)
                    .onAppear {
                        vm.locations.start()
                    }
            }
            .task {
               
                    vm.loadImageJsonFile()
                
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        MapPhotoView()
                    } label: {
                        Image(systemName: "map.circle.fill")
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
            .environmentObject(VieModel())
    }
}
