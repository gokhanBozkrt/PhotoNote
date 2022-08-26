//
//  HomeView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 26.08.2022.
//

import SwiftUI

struct HomeView: View {
   
    static let tag: String? = "Home"
    @State private var showPhotoPicker = false
    @FetchRequest(sortDescriptors: []) private var images: FetchedResults<ImageEntity>
   
    var body: some View {
        NavigationView {
                  List {
                        ForEach(images) { image in
                            NavigationLink {
                                PhotoDetailScreen(image: image)
                            } label: {
                                VStack(alignment: .leading) {
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
                                .padding(.bottom)
                            }
                       }
                        
                }
                }
                  .background(Color.systemGroupedBackground.ignoresSafeArea())
                .listStyle(.insetGrouped)
                  .padding(.top)
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


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
