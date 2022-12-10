//
//  ThruHomeView2.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 12/7/22.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

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
    @State private var imageURL = URL(string: "")
    @State private var imageURLs: [URL] = []
    
    var body: some View {
        // The VStack below is how you can get the webimages from url. Note that you have to import SDWebImageSwiftUI
//        VStack{
//            Text("\(imageURL?.absoluteString ?? "placeholder")").onAppear(perform: loadImageFromFirebase)
//
//            // Puts each image from the imageURLs list into a WebImage
//            ForEach(0..<imageURLs.count, id: \.self){ index in
//                WebImage(url: imageURLs[index])
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
//            WebImage(url: imageURL)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//        }
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
    }
    
//    // Loads all the image URLs from firebase and appends them to the imageURLs list.
//    func loadImageFromFirebase() {
//        let storageRef = Storage.storage().reference().child("images")
//        storageRef.listAll { (result, error) in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            print(result!.items.count)
//            for item in result!.items {
//                item.downloadURL { (url, error) in
//                    if error != nil {
//                        print((error?.localizedDescription)!)
//                        return
//                    }
//                    self.imageURLs.append(url!)
//                }
//            }
//        }

        // This is is you want to download a single image with instead of child you just use reference and the path.
//        storageRef.downloadURL { (url, error) in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            self.imageURL = url!
//        }
    }
    
    struct ThruHomeView2_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                ThruHomeView2(buttons: ThruButton.buttons)
            }
        }
    }
//}
