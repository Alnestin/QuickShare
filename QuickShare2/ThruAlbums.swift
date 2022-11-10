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
    var freq: String
    var endDate: Int
    var description: String
    
    init(id: UUID = UUID(), title: String, symbol: String, description: String, freq: String) {
        self.id = id
        self.title = title
        self.symbol = symbol
        self.description = description
        self.endDate = 0
        self.freq = freq
    }
    
    struct Data {
        var symbol: String = "🪴"
        var title: String = "Plant 1"
        var freq: String = "None"
        var endDate: Int = 5
        var description: String = "My first plant."
    }
    
    var data: Data {
        Data(symbol: symbol, title: title, freq: freq, endDate: endDate, description: description)
    }
}
extension ThruAlbum {
    static let albums: [ThruAlbum] =
    [
        ThruAlbum(title: "Plant", symbol: "🪴", description: "My first plant", freq: "Every Week"),
        ThruAlbum(title: "Me", symbol: "👨‍🎓", description: "Me", freq: "None"),
        ThruAlbum(title: "Dog", symbol: "🐶", description: "My first pet", freq: "Every Day"),
        ThruAlbum(title: "Family", symbol: "👨‍👩‍👦", description: "My fam", freq: "Every Year")
    ]
}
