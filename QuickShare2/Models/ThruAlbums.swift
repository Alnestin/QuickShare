//
//  ThruAlbums.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import Foundation
import SwiftUI

struct ThruAlbum: Identifiable {
    let id: UUID
    var title: String
    var symbol: String
    var freq: String
    var endDate: Int
    var description: String
    var photos: [Image]
    var albumType: String
    
    init(id: UUID = UUID(), title: String, symbol: String, description: String, freq: String, photos: [Image], albumType: String) {
        self.id = id
        self.title = title
        self.symbol = symbol
        self.description = description
        self.endDate = 0
        self.freq = freq
        self.photos = photos
        self.albumType = albumType
    }
    
    struct Data {
        var symbol: String = ""
        var title: String = "Untitled"
        var freq: String = "Never"
        var endDate: Int = 0
        var description: String = ""
        var photos: [Image] = []
        var albumType: String = "ThruTime"
    }
    
    mutating func update(from data: Data) {
        title = data.title
        symbol = data.symbol
        freq = data.freq
        description = data.description
        photos = data.photos
        albumType = data.albumType
    }
    mutating func getAlbumType(from data: Data) -> String {
        return data.albumType
    }
    
    var data: Data {
        Data(symbol: symbol, title: title, freq: freq, endDate: endDate, description: description, photos: photos, albumType: albumType)
    }
    
    init(data: Data) {
        id = UUID()
        title = data.title
        symbol = data.symbol
        freq = data.freq
        endDate = 0
        description = data.description
        photos = data.photos
        albumType = data.albumType
        }
}
extension ThruAlbum {
    static let albums: [ThruAlbum] =
    [
        ThruAlbum(title: "Plant", symbol: "🪴", description: "My first plant", freq: "Every Week", photos: [Image("Image 1"), Image("Image 2"), Image("Image 3"), Image("Image 4")], albumType: "ThruTime"),
        ThruAlbum(title: "Me", symbol: "👨‍🎓", description: "Me", freq: "Never", photos: [], albumType: "ThruDates"),
        ThruAlbum(title: "Dog", symbol: "🐶", description: "My first pet", freq: "Every Day", photos: [], albumType: "ThruPlaces"),
        ThruAlbum(title: "Family", symbol: "👨‍👩‍👦", description: "My fam", freq: "Every Year", photos: [], albumType: "ThruPeople")
    ]
}
