//
//  ImageListView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 1.09.2022.
//

import SwiftUI

struct ImageListView: View {
    @ObservedObject var  image: ImageEntity
    var body: some View {
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
        
    }
}



