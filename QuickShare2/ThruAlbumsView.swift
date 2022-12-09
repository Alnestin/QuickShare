//
//  ThruAlbumsView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct AlbumsView: View {
    @State private var isPresentingNewAlbumView = false
    let button: ThruButton
    @Binding var albums: [ThruAlbum]
    @State private var newAlbumData = ThruAlbum.Data()
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                ForEach($albums) { $album in
                    if (button.title == album.albumType)
                    {
                        NavigationLink(destination: PhotosView(album: $album)) {
                            AlbumButtonView(album: album)
                        }
                    }
                }.onDelete { (indexSet) in
                    albums.remove(atOffsets: indexSet)
                }
            }
        }
        .toolbar {
            Button(action: {isPresentingNewAlbumView = true}) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingNewAlbumView) {
            NavigationView {
                EditView(data: $newAlbumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewAlbumView = false
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text("New Album").font(Font.headline.weight(.bold))
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                newAlbumData.albumType = button.title
                                let newAlbum = ThruAlbum(data: newAlbumData)
                                albums.append(newAlbum)
                                isPresentingNewAlbumView = false
                            }
                        }
                    }
            }
        }
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumsView(button: ThruButton.buttons[0], albums: .constant(ThruAlbum.albums))
        }
    }
}
