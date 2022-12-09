//
//  QuickShare2App.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/20/22.
//

import SwiftUI

@main
struct QuickShare2: App {
    @State private var buttons = ThruButton.buttons
    var body: some Scene {
        WindowGroup {
                ThruHomeView2(buttons: buttons).navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
