//
//  PhotosView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/21/22.
//

import SwiftUI
import FirebaseStorage

struct PhotosView: View {
    @Binding var album: ThruAlbum
    @State private var data = ThruAlbum.Data()
    @State private var photo = 0
    @State private var isPresentingEditView = false
    
    // Things needed to use camera roll or photo library
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var imageUrl: URL? // The image url used to upload the picture to firebase
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        
        VStack{
            GeometryReader{ proxy in
                TabView(selection: $photo){
                    ForEach(0..<album.photos.count, id: \.self){index in
                        album.photos[index]
                            .resizable()
                            .scaledToFill()
                            .scaleEffect()
                            .frame(width: proxy.size.width/1.05, height: proxy.size.height)
                            .cornerRadius(24)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            Spacer().frame(height:20)
            Menu {
                Button {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                } label: {
                    Label("Camera", systemImage: "camera")
                }
                Button {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                } label: {
                    Label("Photo Library", systemImage: "photo.on.rectangle")
                }
            } label: {
                Image(systemName: "plus")
                    .frame(width: 30, height: 40)
                    .foregroundColor(Color.black)
            }.onChange(of: selectedImage, perform: { _ in
                data = album.data
                data.photos.append(Image(uiImage: selectedImage!))
                album.update(from: data)
                uploadPicture(fileUrl: imageUrl!)
            })
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
        
        .navigationTitle(album.symbol + " " + album.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = album.data
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView {
                EditView(data: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text(album.title).font(Font.headline.weight(.bold))
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                album.update(from:data)
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, imageUrl: self.$imageUrl, sourceType: self.sourceType)
        }
    }
    
    // This method allows you to upload a picture through its url
    func uploadPicture(fileUrl: URL) {
        let fileName = "\(album.photos.count).jpeg" // TODO: Change this to always output a different name, idk how
        let storageRef = Storage.storage().reference().child(fileName)
        print(fileUrl)
        storageRef.putFile(from: fileUrl, metadata: nil) { (metadata, error ) in
            guard let error = error else {
                if error != nil {
                    print("Something went wrong!")
                }
                return
              }
        }
    }
}
    
struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotosView(album: .constant(ThruAlbum.albums[0]))
        }
    }
}
