//
//  ScrumsView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct ScrumsView: View {
    let buttons: [ThruButton]
    
    var body: some View {
        List {
            ForEach(buttons) { button in
                NavigationLink(destination: Text(button.title)) {
                    CardView(button: button)
                }
            }
        }
        .navigationTitle("ThruTime")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "person")
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(buttons: ThruButton.buttons)
        }
    }
}
