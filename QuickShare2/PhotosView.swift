//
//  PhotosView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/21/22.
//

import SwiftUI

struct PhotosView: View {
    let album: ThruAlbum
    @State private var images: [Image] = [Image("Image 1"), Image("Image 2"), Image("Image 3")]
    @State private var data = ThruAlbum.Data()
    @State private var photo = 0
    @State private var isPresentingEditView = false
    
    // Things needed to use camera roll or photo library
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                TabView(selection: $photo){
                    ForEach(0...images.count - 1, id: \.self){index in
                        images[index]
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(24)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: proxy.size.width, height: proxy.size.height/1.3)
            }
            
            // TODO: Add another button to use sourceType = .camera?
            Button() {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 40, height: 40)
                    .background(Color.black)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }.onChange(of: selectedImage, perform: { _ in
                images.append(Image(uiImage: selectedImage!))
            })
        }
        .navigationTitle(album.symbol + " " + album.title)
        .toolbar {
            Button(action: {isPresentingEditView = true}) {
                Text("Edit")
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
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}
    
struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotosView(album: ThruAlbum.albums[0])
        }
    }
}
