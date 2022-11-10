//
//  PhotosView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/21/22.
//

import SwiftUI

struct PhotosView: View {
    let album: ThruAlbum
    //    let albums: [ThruAlbum]
    @State private var data = ThruAlbum.Data()
    @State private var photo = 1
    @State private var isPresentingEditView = false
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                TabView(selection: $photo){
                    ForEach(1...30, id: \.self){index in
                        Image("Image \((Int(index)%3)+1)")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(24)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: proxy.size.width, height: proxy.size.height/1.3)
            }
            
            Button{} label: {
                Image(systemName: "plus")
                //                    .resizable()
                //                    .padding(6)
                    .frame(width: 40, height: 40)
                    .background(Color.black)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
        .navigationTitle(album.symbol + " " + album.title)
        .toolbar {
            Button(action: {isPresentingEditView = true}) {
                Text("Edit")
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationView {
                EditView(data: $data)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Text(album.title).font(Font.headline.weight(.bold))
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}
    
struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhotosView(album: ThruAlbum.albums[0])
        }
    }
}
