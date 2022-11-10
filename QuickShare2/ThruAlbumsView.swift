//
//  ThruAlbumsView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct AlbumsView: View {
    @State private var isPresentingEditView = false
    let button: ThruButton
    let albums: [ThruAlbum]
    var body: some View {
        List {
            Section(header: Text("Albums")) {
                ForEach(albums) { album in
                    NavigationLink(destination: PhotosView(album: album)) {
                        AlbumButtonView(album: album)
                    }
                }
            }
        }
        .navigationTitle(button.title)
        .toolbar {
            Button(action: {isPresentingEditView = true}) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isPresentingEditView) {}
        //        NavigationView {
        //            EditView()
        //                .toolbar {
        //                    ToolbarItem(placement: .cancellationAction) {
        //                        Button("Cancel") {
        //                            isPresentingEditView = false
        //                        }
        //                    }
        //                    ToolbarItem(placement: .principal) {
        //                        Text("New Album").font(Font.headline.weight(.bold))
        //                    }
        //                    ToolbarItem(placement: .confirmationAction) {
        //                        Button("Done") {
        //                            isPresentingEditView = false
        //                        }
        //                    }
        //                }
        //        }
    }
}
    

//var body: some View {
//    List {
//        Section(header: Text("Meeting Info")) {
//            NavigationLink(destination: MeetingView()) {
//                Label("Start Meeting", systemImage: "timer")
//                    .font(.headline)
//                    .foregroundColor(.accentColor)
//            }
//            HStack {
//                Label("Length", systemImage: "clock")
//                Spacer()
//                Text("\(scrum.lengthInMinutes) minutes")
//            }
//            .accessibilityElement(children: .combine)
//            HStack {
//                Label("Theme", systemImage: "paintpalette")
//                Spacer()
//                Text(scrum.theme.name)
//                    .padding(4)
//                    .foregroundColor(scrum.theme.accentColor)
//                    .background(scrum.theme.mainColor)
//                    .cornerRadius(4)
//            }
//            .accessibilityElement(children: .combine)
//        }
//        Section(header: Text("Attendees")) {
//            ForEach(scrum.attendees) { attendee in
//                Label(attendee.name, systemImage: "person")
//            }
//        }
//}
struct AlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumsView(button: ThruButton.buttons[0], albums: ThruAlbum.albums)
        }
    }
}
