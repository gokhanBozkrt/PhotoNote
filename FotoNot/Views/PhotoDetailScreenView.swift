//
//  PhotoDetailScreenView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 30.08.2022.
//
import CoreData
import SwiftUI
import MapKit

struct PhotoDetailScreen: View {
    @EnvironmentObject var locationManager: LocationFetcher
    @EnvironmentObject var dataController: DataController
    @ObservedObject var image: ImageEntity
    @State private var isFavourite: Bool
    @State private var currentAmount: CGFloat = 0
    @State private var endAmount: CGFloat = 0
    @State private var selectedView = 0
    
   @State private var mapRegion: MKCoordinateRegion
    
    init(image: ImageEntity) {
        self.image = image
        _isFavourite = State(wrappedValue: image.favourite)
        self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: image.latitude , longitude: image.longitude) , span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
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
                    phtoMapView
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
struct PhotoDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailScreen()
    }
}
*/

extension PhotoDetailScreen {
    private var photoFullView: some View {
        VStack {
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
                Spacer()
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
    }
    private var phtoMapView: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $mapRegion ,annotationItems: [image]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(uiImage: image.viewerImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())

                        }
                    }
                }

            }
            .ignoresSafeArea()
            .padding()
           ResultView(image: image)
            
        }
    }
    
  
}
