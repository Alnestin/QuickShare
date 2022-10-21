//
//  PhotosView.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/21/22.
//

import SwiftUI

struct PhotosView: View {
//    let button: ThruButton
//    let albums: [ThruAlbum]
    @State private var photo = 1.0
    @State private var isEditing = false
    var body: some View {
        Image("Image " + String(Int(photo))).resizable().frame(width: 200.0, height: 200.0)
        Slider(
            value: $photo,
            in: 1...3,
            step: 1
//            onEditingChanged: { editing in
//                            isEditing = editing
//                        }
        )
//        Text("\(photo)")
//                    .foregroundColor(isEditing ? .red : .blue)
    }
}
    
//struct PhotosView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            PhotosView(button: ThruButton.buttons[0], albums: ThruAlbum.albums)
//        }
//    }
//}
