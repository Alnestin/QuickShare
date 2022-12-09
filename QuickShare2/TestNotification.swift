//
//  TestNotification.swift
//  QuickShare2
//
//  Created by Ernesto Zubillaga on 12/8/22.
//

import SwiftUI

struct TestNotification: View {
    @State private var id = 0
    var body: some View {
        VStack (spacing: 50){
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
                print("notif")
            }
        }
    }
}

struct TestNotification_Previews: PreviewProvider {
    static var previews: some View {
        TestNotification()
    }
}
