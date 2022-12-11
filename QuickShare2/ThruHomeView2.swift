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
        TabView(selection: $selectedTab) {
            ForEach(0..<4) { i in
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                            ForEach($albums) { $album in
                                if (buttons[selectedTab].title == album.albumType)
                                {
                                    NavigationLink(destination: PhotosView(album: $album)) {
                                        AlbumButtonView(album: album)
                                            .cornerRadius(15)
                                            .contextMenu {
                                                
                                                Button (action: {
//                                                    let d = album.photos.remove(at: album.photos.index(of: album))
                                                    deleteAlbum(album: album)
                                                }){
                                                    Image(systemName: "trash")
                                                    Text("Delete")
                                                }
                                                
                                            }
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle(buttons[i].title)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {}, label: {
                                Image(systemName: "person")
                            })
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {isPresentingNewAlbumView = true}, label: {
                                Image(systemName: "plus")
                            })
                        }
                    }
                    .sheet(isPresented: $isPresentingNewAlbumView) {
                        NavigationView {
                            EditView(data: $newAlbumData)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Dismiss") {
                                            isPresentingNewAlbumView = false
                                        }
                                    }
                                    ToolbarItem(placement: .principal) {
                                        Text("New Album").font(Font.headline.weight(.bold))
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Add") {
                                            let newAlbum = ThruAlbum(data: newAlbumData)
                                            albums.append(newAlbum)
                                            uploadAlbumData(album: newAlbum)
                                            isPresentingNewAlbumView = false
                                        }
                                    }
                                }
                        }
                    }
                }
                .tabItem {
                    Image(systemName: buttons[i].symbol)
                    Text(buttons[i].title)
                }.tag(i)
            }
        }
        .onAppear(perform: loadImageFromFirebase)
    }
    
    // When an album is created, create it in firebase
    func uploadAlbumData(album: ThruAlbum) {
        // Put album data into a dictionary
        let dic: [String: Any] = ["id": album.id.uuidString, "title": album.title, "description": album.description,
                                  "symbol": album.symbol, "freq": album.freq, "type": album.albumType]
        let fileName = "metadata.json"
        
        do {
            // Put the data in a json file.
            let fileUrl = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)

            try JSONSerialization.data(withJSONObject: dic)
                .write(to: fileUrl)
            
            // Create the album in the database and put the metadata.
            let filePath = "/user1/\(album.albumType)/\(album.title)/\(fileName)"
            let storageRef = Storage.storage().reference().child(filePath)
            storageRef.putFile(from: fileUrl, metadata: nil) { (metadata, error ) in
                guard let error = error else {
                    if error != nil {
                        print((error?.localizedDescription)!)
                    }
                    return
                }
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAlbum(album: ThruAlbum) {
        let fileName = "user1/\(album.albumType)/\(album.title)"
        let storageRef = Storage.storage().reference().child(fileName)
        
        storageRef.delete {error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Pic deleted")
            }
        }
    }
    // Loads all the image URLs from firebase and appends them to the imageURLs list.
    func loadImageFromFirebase() {
        for loc in ["ThruTime", "ThruPeople", "ThruDates", "ThruPlaces"] {
            let storageRef = Storage.storage().reference().child("user1/" + loc)
            storageRef.listAll { (result, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                for p in result!.prefixes {
                    p.listAll{ (imgs , err) in
                        if err != nil {
                            print((err?.localizedDescription)!)
                            return
                        }
                        let newAlbum = ThruAlbum(title: p.name, symbol: "", description: "", freq: "", photos: [], albumType: loc)
                        for item in imgs!.items {
                            if item.name.hasSuffix(".json") {
                                continue
                            }
                            print(item.name)
                            item.downloadURL { (url, err1) in
                                if err1 != nil {
                                    print((err1?.localizedDescription)!)
                                    return
                                }
                                for i in 0..<self.albums.count {
                                    if newAlbum.title == self.albums[i].title {
                                        self.albums[i].photos.append(url!)
                                        self.albums[i].photos = self.albums[i].photos.sorted( by:{
                                            
                                            let c1 = $0.lastPathComponent.components(separatedBy: ".")
                                            let c2 = $1.lastPathComponent.components(separatedBy: ".")
                                            
                                            let v1 = Int(c1[0].prefix(16))
                                            let v2 = Int(c2[0].prefix(16))
                                            
                                            return v1! < v2!
                                        })
                                        
                                    }
                                }
                            }
                        }
                        self.albums.append(newAlbum)
                    }
                }
            }
            
            // This is is you want to download a single image with instead of child you just use reference and the path.
            storageRef.downloadURL { (url, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                self.imageURL = url!
            }
        }
    }
}
    
struct ThruHomeView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThruHomeView2(buttons: ThruButton.buttons)
        }
    }
}
