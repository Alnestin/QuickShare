//
//  ThruAlbums.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import Foundation

struct ThruAlbum: Identifiable {
    let id: UUID
    var title: String
    var symbol: String
    
    init(id: UUID = UUID(), title: String, symbol: String) {
        self.id = id
        self.title = title
        self.symbol = symbol
    }
}

extension ThruAlbum {
    static let albums: [ThruAlbum] =
    [
        ThruAlbum(title: "Plant", symbol: "🪴"),
        ThruAlbum(title: "Me", symbol: "👨‍🎓"),
        ThruAlbum(title: "Dog", symbol: "🐶"),
        ThruAlbum(title: "Family", symbol: "👨‍👩‍👦")
    ]
}
