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
            ScrollView {
                ForEach(sortedImage(for: images)) { image in
                    NavigationLink {
                        PhotoDetailScreen(image: image)
                    } label: {
                        LazyVStack(alignment: .leading) {
                            HStack(spacing:10) {
                                Image(uiImage: image.viewerImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                VStack(alignment: .leading,spacing: 3) {
                                    Text(image.imageName)
                                        .font(.title)
                                        .foregroundColor(.black.opacity(0.8))
                                    Text(image.imageRecordDate)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                    
                                }
                                
                                if image.favourite {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .accessibilityLabel("This is a favourite image")
                                }
                            }
                          
                        }
                        .padding()
                        .background(Color.secondarySystemGroupedBackground)
                    }
                    
                }
                .onDelete { offsets in
                    for offset in offsets {
                        let image = images[offset]
                        dataController.delete(image)
                    }
                    dataController.save()
                    
                }
                
            }.navigationTitle("Foto Notes")
                .background(Color.systemGroupedBackground.ignoresSafeArea())
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
