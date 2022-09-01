//
//  PhotoDetailView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 1.09.2022.
//

import CoreData
import SwiftUI
import MapKit

struct PhotoDetailView: View {
    @EnvironmentObject var locationManager: LocationFetcher
    @EnvironmentObject var dataController: DataController
    @ObservedObject var image: ImageEntity
    @State private var isFavourite: Bool
    @State private var selectedView = 0
    
    
    
    @State private var currentAmount: CGFloat = 0
    @State private var endAmount: CGFloat = 0
    
    init(image: ImageEntity) {
        self.image = image
        _isFavourite = State(wrappedValue: image.favourite)
        
    }
    
    var body: some View {
        VStack {
            Picker("Select A view ", selection: $selectedView) {
                Text("Photo").tag(0)
                Text("Map").tag(1)
            }.pickerStyle(.segmented)
            if selectedView == 0 {
                photoFullView
                
            } else {
                mapView
            }
            
            Spacer()
        }

        .navigationTitle(image.imageName)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func update() {
        image.objectWillChange.send()
        image.favourite = isFavourite
        dataController.save()
    }
}


/*
 struct PhotoDetailView_Previews: PreviewProvider {
 static var previews: some View {
 PhotoDetailScreen()
 }
 }
 */

extension PhotoDetailView {
    private var photoFullView: some View {
        VStack {
            ZStack {
                Image(uiImage: image.viewerImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .scaleEffect(1 + currentAmount)
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                currentAmount = value - 1
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    currentAmount = 0
                                }
                            })
                    )
            }
            
            if currentAmount == 0 {
                Button(image.favourite ? "Remove from favourites" : "Add to favourites") {
                    if !image.favourite {
                        isFavourite = true
                        
                    } else {
                        isFavourite = false
                    }
                    update()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            Spacer()
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
    }
    private var mapView: some View {
        VStack {
            PhotoMapView(image: image)
            
            ResultView(image: image)
            
        }
    }
    
    
}
