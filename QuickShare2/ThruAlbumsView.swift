//
//  ThruAlbumsView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct AlbumsView: View {
    let button: ThruButton
    let albums: [ThruAlbum]
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                ForEach(albums) { album in
                    NavigationLink(destination: PhotosView()) {
                        AlbumButtonView(album: album)
                    }
                }
            }
            .navigationTitle(button.title)
        }
    }
}
    
struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumsView(button: ThruButton.buttons[0], albums: ThruAlbum.albums)
        }
    }
}
