//
//  DetailPhotoView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 11/10/22.
//

import SwiftUI

struct DetailPhotoView: View {
    let photo: Image
    var body: some View {
        photo
    }
}

struct DetailPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPhotoView(photo: Image("Image 1"))
    }
}
