//
//  QuickShare2App.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/20/22.
//

import SwiftUI

@main
struct QuickShare2: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(buttons: ThruButton.buttons)
//                ContentView()
            }
        }
    }
}
