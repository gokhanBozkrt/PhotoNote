//
//  PhotoDetailScreen.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import SwiftUI

struct PhotoDetailScreen: View {
   
    @EnvironmentObject var dataController: DataController
    let image: ImageEntity
    @State private var isFavourite: Bool
    @State private var currentAmount: CGFloat = 0
    @State private var endAmount: CGFloat = 0
    
    init(image: ImageEntity) {
        self.image = image
        _isFavourite = State(wrappedValue: image.favourite)
    }
    
    var body: some View {
        
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
                  Spacer()
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
            .background(Color.systemGroupedBackground.ignoresSafeArea())
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


/*
 if favourites.contains(resort) {
     Spacer()
     Image(systemName: "heart.fill")
         .foregroundColor(.red)
         .accessibilityLabel("This is a favoute resort")
 }
 */
