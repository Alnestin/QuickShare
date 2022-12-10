//
//  QuickShare2App.swift
//  QuickShare2
//
//  Created by Martin Heberling on 10/20/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct QuickShare2: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var buttons = ThruButton.buttons
    var body: some Scene {
        WindowGroup {
            ThruHomeView2(buttons: buttons).navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
