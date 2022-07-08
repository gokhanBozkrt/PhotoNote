//
//  PhotoPickerView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import SwiftUI

struct PhotoPickerView: View {
    @EnvironmentObject var vm : VieModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                
                VStack {
                    TextField("Foto Adı", text: $vm.imageName)
                    HStack {
                        Button {
                            vm.source = .camera
                            vm.showPhotoPicker()
                        } label: {
                            ButtonLabelView(systemImageName: "camera", textName:"Camera")
                        }
                        .alert("Error",isPresented: $vm.showCameraAlert) {
                            vm.cameraError?.button
                        } message: {
                            Text(vm.cameraError?.message ?? "")
                        }
                        
                        Button {
                            vm.source = .library
                            vm.showPicker = true
                        } label: {
                            ButtonLabelView(systemImageName: "photo", textName: "Photos")
                        }

                    }
                    
                    Button {
                        vm.addImage(vm.imageName, image: vm.image!)
                        dismiss()
            
                    } label: {
                        ButtonLabelView(systemImageName: "square.and.arrow.down.fill", textName: "Save")
                    }

                }
                .padding()
               Spacer()
            }.navigationTitle("Foto Seç")
            .navigationBarTitleDisplayMode(.inline)            
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
        }
        }
    }
}


struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
            .environmentObject(VieModel())
    }
}
 
