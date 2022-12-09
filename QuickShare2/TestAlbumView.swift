//
//  TestAlbumView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 12/7/22.
//

import SwiftUI

struct TestAlbumView: View {
    
    var buttons: [ThruButton]
    @Binding var albums: [ThruAlbum]
    @State private var selectedTab = 0
    let photos = ["Image 1", "Image 2", "Image 3", "Image 1", "Image 2", "Image 3"]
    private let gridItemLayout = [
        GridItem(.fixed(100), spacing: 75, alignment: .center),
        GridItem(.fixed(100), spacing: 75, alignment: .center)
    ]
    var body: some View {
        TabView(selection: $selectedTab){
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach($albums) { $album in
                        
                        //                        VStack{
                        //                            Image(photos[i])
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .cornerRadius(10)
                        //                            Text("Hola")
                        //                                .font(.headline)
                        //                        }
                        NavigationLink(destination: PhotosView(album: $album)) {
                            
                            AlbumButtonView(album: album)
                            
                        }
                    }
                }
            }.tabItem {
                Image(systemName: "house")
                Text("Home")
            }.tag(0)
            NavigationView{
                Text("Salut, tout le monde!")
            }.tabItem {
                Image(systemName: "timelapse")
                Text("Space")
            }.tag(1)
        }.navigationTitle(buttons[selectedTab].title)
    }
}
    

struct TestAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TestAlbumView(buttons: ThruButton.buttons, albums: .constant(ThruAlbum.albums))
        }
    }
}
