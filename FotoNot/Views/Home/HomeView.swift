//
//  HomeView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 26.08.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dataController: DataController
    static let tag: String? = "Home"
    @State private var showPhotoPicker = false
    @State private var showSortOrderOptions = false
    
    @FetchRequest(sortDescriptors: []) private var images: FetchedResults<ImageEntity>
    enum SortOrder {
        case name,creationDateReverse,optimized
    }
    @State private var sortOder: SortOrder = .optimized
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedImage(for: images)) { image in
                    NavigationLink {
                       PhotoDetailView(image: image)
                    } label: {
                    ImageListView(image: image)
                    }
                    
                }
                .onDelete { offsets in
                    for offset in offsets {
                        let allImages = sortedImage(for: images)
                        let image = allImages[offset]
                        dataController.delete(image)
                    }
                    dataController.save()
                    
                }
                
            }
            .listStyle(.inset)
            .navigationTitle("Photo Notes")
                .background(Color.secondarySystemGroupedBackground.ignoresSafeArea())
                .padding(.top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showPhotoPicker = true
                            
                        } label: {
                            Label("Add Image",systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showSortOrderOptions.toggle()
                        } label: {
                            Label("Sort",systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
                .sheet(isPresented: $showPhotoPicker) {
                    PhotoPickerView()
                }
                .confirmationDialog("Sort", isPresented: $showSortOrderOptions) {
                    Button("Optimized") {  sortOder = .optimized }
                    Button("Name") {  sortOder = .name }
                    Button("Creation Date Reverse") { sortOder = .creationDateReverse }
                } message: {
                    Text("Sort Photo Notes")
                }
            
        }
    }
    
    func sortedImage(for images: FetchedResults<ImageEntity>) -> [ImageEntity] {
        switch sortOder {
        case .name:
            return images.sorted { $0.imageName < $1.imageName }
        case .creationDateReverse:
            return images.sorted { $0.imageRecordDate > $1.imageRecordDate }
        case .optimized:
            return images.sorted { $0.imageRecordDate < $1.imageRecordDate }

        }
    }
    
}
    
struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
