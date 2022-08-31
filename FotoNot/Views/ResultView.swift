//
//  ResultView.swift
//  FotoNot
//
//  Created by Gokhan Bozkurt on 31.08.2022.
//

import SwiftUI

struct ResultView: View {
    @StateObject var vm: ResultViewModel
    var body: some View {
        Form {
            Section("Nearby....") {
                switch vm.loadingState {
                case .loading:
                    Text("Loading..")
                case .loaded:
                    ForEach(vm.pages, id: \.pageid) { page in
                        Text(page.title)
                            .font(.headline)
                        + Text(": ")
                        + Text(page.descriptionTerms)
                            .italic()
                        
                    }
                case .failed:
                    Text("Please try again")
                }
            }

        } .task {
            await vm.fetchNearPlaces()
        }
    }
    init(image: ImageEntity) {
        _vm = StateObject(wrappedValue: ResultViewModel(image: image))
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}
