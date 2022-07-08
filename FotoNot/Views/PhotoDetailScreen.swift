//
//  PhotoDetailScreen.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import SwiftUI

struct PhotoDetailScreen: View {
    let image: UIImage
    let title: String
    @State private var currentAmount: CGFloat = 0
    @State private var endAmount: CGFloat = 0
    
    var body: some View {
        VStack {
            Image(uiImage: image)
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
        
        .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}


/*
struct PhotoDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailScreen()
    }
}
*/
