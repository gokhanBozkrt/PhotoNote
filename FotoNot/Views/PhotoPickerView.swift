//
//  PhotoPickerView.swift
//  FotoNot
//
//  Created by Gökhan Bozkurt on 4.06.2022.
//

import SwiftUI

struct PhotoPickerView: View {
    @State private var image: UIImage?
    @Environment(\.dismiss) var dismiss
    @State private var showPicker = false
    @State var source: Picker.Source = .library
    @State private var imageName = ""
    @State private var showCameraAlert = false
    @State private var cameraError: Picker.CameraErrorType?
    
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
                    HStack {
                        Button {
                            source = .camera
                            showPhotoPicker()
                        } label: {
                            ButtonLabelView(systemImageName: "camera", textName:"Camera")
                        }
                        .alert("Error",isPresented: $showCameraAlert) {
                            cameraError?.button
                        } message: {
                            Text(cameraError?.message ?? "")
                        }
                        
                        Button {
                            source = .library
                            showPicker = true
                        } label: {
                            ButtonLabelView(systemImageName: "photo", textName: "Photos")
                        }

                    }
                    
                    Button {
                      let imageEntity = ImageEntity(context: managedObjectContext)
                        imageEntity.name = imageName
                        imageEntity.id = UUID()
                        imageEntity.latitude = 39.941959
                        imageEntity.longitude = 32.8077479
                        
                        guard let savedImage = image else {
                            return
                        }
                        imageEntity.image = savedImage.jpegData(compressionQuality: 0.9)
                     
                        dataController.save()
                        dismiss()
                    } label: {
                        ButtonLabelView(systemImageName: "square.and.arrow.down.fill", textName: "Save")
                    }

                }
                .padding()
               Spacer()
            }.navigationTitle("Foto Seç")
            .navigationBarTitleDisplayMode(.inline)            
            .sheet(isPresented: $showPicker) {
                ImagePicker(sourceType: source == .library ? .photoLibrary : .camera, selectedImage: $image)
        }
        }
    }
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
                showPicker = true
            }
          
        } catch  {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
    
}


struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
        
    }
}
 
