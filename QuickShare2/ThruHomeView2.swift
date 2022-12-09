//
//  ThruHomeView2.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 12/7/22.
//

import SwiftUI

struct ThruHomeView2: View {
    let buttons: [ThruButton]
    @State private var isPresentingNewAlbumView = false
    @State private var albums = ThruAlbum.albums
    @State private var newAlbumData = ThruAlbum.Data()
    @State private var selectedTab = 0
    private let gridItemLayout = [
        GridItem(.fixed(100), spacing: 95, alignment: .center),
        GridItem(.fixed(100), spacing: 95, alignment: .center)
    ]
    
    var body: some View {
        TabView(selection: $selectedTab){
            //            ForEach(buttons) { button in
            //                AlbumsView(button: button, albums: $albums)
            //                    .tabItem {
            //                        Label(button.title, systemImage: button.symbol)
            //
            //                    }
            //            }
            //        }

            ForEach(0..<5) { i in
                    if i != 2 {
                        NavigationStack {
                            ScrollView {
                                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                    ForEach($albums) { $album in
                                        if (buttons[selectedTab].title == album.albumType)
                                        {
                                            NavigationLink(destination: PhotosView(album: $album)) {
                                                AlbumButtonView(album: album)
                                                    .cornerRadius(15)
                                            }
                                        }
                                    }
                                }
                            }
                            .navigationTitle(buttons[i].title)
                        }
                        .tabItem {
                            Image(systemName: buttons[i].symbol)
                            Text(buttons[i].title)
                        }.tag(i)

                    } else {
                        Text("Hola")
                            .tabItem {
                                Image(systemName: buttons[i].symbol)
                                Text(buttons[i].title)
                            }.tag(i)
                    }
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {}, label: {
//                    Image(systemName: "person")
//                })
//            }
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {isPresentingNewAlbumView = true}, label: {
//                    Image(systemName: "plus")
//                })
//            }
//        }
//        .sheet(isPresented: $isPresentingNewAlbumView) {
//            NavigationView {
//                EditView(data: $newAlbumData)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Dismiss") {
//                                isPresentingNewAlbumView = false
//                            }
//                        }
//                        ToolbarItem(placement: .principal) {
//                            Text("New Album").font(Font.headline.weight(.bold))
//                        }
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button("Add") {
//                                let newAlbum = ThruAlbum(data: newAlbumData)
//                                albums.append(newAlbum)
//                                isPresentingNewAlbumView = false
//                            }
//                        }
//                    }
//            }
//        }
    }
}

struct ThruHomeView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThruHomeView2(buttons: ThruButton.buttons)
        }
    }
}
