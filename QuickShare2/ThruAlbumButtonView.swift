//
//  ThruAlbumButtonView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct AlbumButtonView: View {
    let album: ThruAlbum
    var body: some View {
        HStack {
            Text(album.symbol)
            Text(album.title).font(.headline)
        }.font(.headline)
        .padding()
    }
}

struct AlbumButtonView_Previews: PreviewProvider {
    static var album = ThruAlbum.albums[0]
    static var previews: some View {
        AlbumButtonView(album: album)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
