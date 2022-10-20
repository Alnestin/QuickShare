//
//  ThruButtonView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct ButtonView: View {
    let button: ThruButton
    var body: some View {
        HStack {
            Label("", systemImage: button.symbol)
            Text(button.title).font(.headline)
        }.font(.headline)
        .padding()
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var button = ThruButton.buttons[0]
    static var previews: some View {
        ButtonView(button: button)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
