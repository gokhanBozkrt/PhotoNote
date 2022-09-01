//
//  ResultViewModel.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 31.08.2022.
//

import Foundation

extension ResultView {
 @MainActor class ResultViewModel: ObservableObject {
        
        enum LoadingState {
            case loading, loaded,failed
        }
     @Published var loadingState = LoadingState.loading
     @Published var pages = [Page]()
     var image: ImageEntity
     init(image: ImageEntity) {
            self.image = image
        }
        
     func fetchNearPlaces() async {
         let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(image.latitude)%7C\(image.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
         
         guard let url = URL(string: urlString) else {
             print("Bad URL: \(urlString)")
             return
         }
         
         do {
             let items = try await URLSession.shared.decode(Result.self, from: url)
             self.pages = items.query.pages.values.sorted()
             loadingState = .loaded
         } catch {
             loadingState = .failed
         }
         
     }
        
     
    }
}
