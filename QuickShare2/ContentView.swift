//
//  ContentView.swift
//  QuickShare1
//
//  Created by Ernesto Zubillaga on 10/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//            ProgressView(value: 5, total: 15)
//        }
//        .padding()
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                Text("Hello")
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
