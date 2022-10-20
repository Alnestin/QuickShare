//
//  ThruButton.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import Foundation

struct ThruButton: Identifiable {
    let id: UUID
    var title: String
    var symbol: String
    
    init(id: UUID = UUID(), title: String, symbol: String) {
        self.id = id
        self.title = title
        self.symbol = symbol
    }
}

extension ThruButton {
    static let buttons: [ThruButton] =
    [
        ThruButton(title: "ThruTime", symbol: "clock"),
        ThruButton(title: "ThruPlaces", symbol: "mappin"),
        ThruButton(title: "ThruPeople", symbol: "person.3"),
        ThruButton(title: "ThruDates", symbol: "calendar")
    ]
}

