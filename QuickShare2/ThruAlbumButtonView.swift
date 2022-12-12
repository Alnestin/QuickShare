//
//  ThruAlbumButtonView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct AlbumButtonView: View {
    let album: ThruAlbum
    
    var body: some View {
        VStack (spacing:10) {
            if let photo = album.photos.first {
                WebImage(url: photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 135)
                    .cornerRadius(15)
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 135)
                    .cornerRadius(15)
                    .foregroundColor(Color.gray)
            }
            HStack {
//                Text(album.symbol + "\n" + album.title).foregroundColor(Color.black)
                Text(album.title).foregroundColor(Color.black)
                    .padding(5)
            }.font(.headline)  
        }
        .background(
            Color.gray
                .brightness(0.35)
        )
    }
}

struct AlbumButtonView_Previews: PreviewProvider {
    static var album = ThruAlbum.albums[0]
    static var previews: some View {
        AlbumButtonView(album: album)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
