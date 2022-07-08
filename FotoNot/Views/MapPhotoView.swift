//
//  MapPhotoView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 5.06.2022.
//
import MapKit
import SwiftUI

struct MapPhotoView: View {
    @EnvironmentObject var vm : VieModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.locations.mapRegion ,annotationItems: vm.myImages) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(uiImage: location.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                        
                    }
                }
            }
               
        }
        .ignoresSafeArea()
       
        
    }
}

struct MapPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        MapPhotoView()
            .environmentObject(VieModel())
    }
}
