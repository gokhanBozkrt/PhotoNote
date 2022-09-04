//
//  GridItemsView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 1.09.2022.
//

import SwiftUI

struct GridItemsView: View {
    let image: ImageEntity
    var body: some View {
        VStack {
            Image(uiImage: image.viewerImage)
                .resizable()
             //   .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 150)
            
            VStack(spacing: 10) {
                Text(image.imageName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(image.imageRecordDate)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(radius: 25)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.blue.opacity(0.4))
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
       RoundedRectangle(cornerRadius: 10)
        .stroke(.white.opacity(0.3))
        )
    }
}

//struct GridItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridItemsView()
//    }
//}
