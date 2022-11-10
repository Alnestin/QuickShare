//
//  PhotosView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/21/22.
//

import SwiftUI

struct PhotosView: View {
    @Binding var album: ThruAlbum
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
            
            // TODO: Add another button to use sourceType = .camera?
            Spacer().frame(height:20)
            Button() {
                self.sourceType = .photoLibrary
//                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 30, height: 40)
                    .foregroundColor(Color.black)
            }.onChange(of: selectedImage, perform: { _ in
                data = album.data
                data.photos.append(Image(uiImage: selectedImage!))
                album.update(from: data)
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
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
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
