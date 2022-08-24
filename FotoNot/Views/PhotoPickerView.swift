//
//  PhotoPickerView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import AVFoundation
import SwiftUI

struct PhotoPickerView: View {
    @State private var image: UIImage?
    @Environment(\.dismiss) var dismiss
   @StateObject var vm = ViewModel()
    @State private var imageName = ""
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = image {
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
                    TextField("Foto Adı", text: $imageName)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.mint.opacity(0.2))
                            .shadow(color: .mint,
                                    radius: 10,
                                    x: 0,
                                    y: 0)
                        
                        )
                        .padding(.bottom)
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
                        withAnimation {
                            let imageEntity = ImageEntity(context: managedObjectContext)
                              imageEntity.name = imageName
                              imageEntity.id = UUID()
                              imageEntity.latitude = 39.941959
                              imageEntity.longitude = 32.8077479
                              imageEntity.creationDate = Date()
                              guard let savedImage = image else {
                                  return
                              }
                            imageEntity.image = savedImage.jpegData(compressionQuality: 1)
                           
                              dataController.save()
                              dismiss()
                        }
                    } label: {
                        ButtonLabelView(systemImageName: "square.and.arrow.down.fill", textName: "Save")
                    }

                }
                .padding()
               Spacer()
            }.navigationTitle("Foto Seç")
            .navigationBarTitleDisplayMode(.inline)            
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $image)
        }
        }
    }
    

  
}


struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
        
    }
}
 
