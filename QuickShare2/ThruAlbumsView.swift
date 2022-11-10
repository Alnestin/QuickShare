//
//  ThruAlbumsView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct AlbumsView: View {
    @State private var isPresentingEditView = false
    let button: ThruButton
    let albums: [ThruAlbum]
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                ForEach(albums) { album in
                    NavigationLink(destination: PhotosView(album: album)) {
                        AlbumButtonView(album: album)
                    }
                }
            }
        }
        .navigationTitle(button.title)
        .toolbar {
            Button(action: {isPresentingEditView = true}) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingEditView) {}
    }
}

struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumsView(button: ThruButton.buttons[0], albums: ThruAlbum.albums)
        }
    }
}
