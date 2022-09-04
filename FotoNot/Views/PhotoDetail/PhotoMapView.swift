//
//  PhotoMapView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 1.09.2022.
//

import SwiftUI
import MapKit

struct PhotoMapView: View {
    
    let image: ImageEntity
    @State private var mapRegion: MKCoordinateRegion
    init(image: ImageEntity) {
        self.image = image
        self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: image.latitude , longitude: image.longitude) , span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    }
    
    var body: some View {
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
    }
}

//struct PhotoMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoMapView()
//    }
//}
