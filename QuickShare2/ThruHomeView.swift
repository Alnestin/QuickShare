//
//  ThruHomeView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct HomeView: View {
    let buttons: [ThruButton]
    @State private var albums = ThruAlbum.albums
    
    var body: some View {
        List {
            Section("Collections"){
                ForEach(buttons) { button in
                    NavigationLink(destination: AlbumsView(button: button, albums: $albums)) {
                        ButtonView(button: button)
                    }
                }
            }
        }
        .navigationTitle("ThruTime")
        //        .navigationBarTitleDisplayMode(.large)
        //        .scrollDisabled(true)
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
