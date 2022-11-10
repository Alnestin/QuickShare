//
//  EditView.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 11/8/22.
//

import SwiftUI

struct EditView: View {
    @Binding var data: ThruAlbum.Data
    @State private var selection = "None"
    let choices = ["Never", "Every Day", "Every Week", "Every 2 Weeks", "Every Month", "Every Year"]

    var body: some View {
        Form{
            Section{
                TextField("Title", text: $data.title).modifier(TextFieldClearButton(text: $data.title))
                TextField("Symbol", text: $data.symbol).modifier(TextFieldClearButton(text: $data.symbol))
                Picker("Frequency", selection: $selection) {
                    ForEach(choices, id: \.self) {
                        Text($0)
                    }
                    Divider()
                    Text("Custom").tag(0)
                }
                .pickerStyle(.menu)
            }
            Section{
                TextField("Notes", text: $data.description, axis: .vertical)
                    .lineLimit(7, reservesSpace: true)
            }
        }
    }
}

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(data: .constant(ThruAlbum.albums[0].data))
    }
}
