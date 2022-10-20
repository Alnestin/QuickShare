//
//  ThruHomeView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct HomeView: View {
    let buttons: [ThruButton]
    
    var body: some View {
        List {
            ForEach(buttons) { button in
                NavigationLink(destination: AlbumsView(button: button, albums: ThruAlbum.albums)) {
                    ButtonView(button: button)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(buttons: ThruButton.buttons)
        }
    }
}
