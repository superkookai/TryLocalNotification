//
//  ContentView.swift
//  TryLocalNotification
//
//  Created by Weerawut Chaiyasomboon on 22/12/2567 BE.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var authorised: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 150))
                .foregroundStyle(.purple,.black)
            
            if authorised {
                Button {
                    scheduleNotification()
                } label: {
                    Text("Send Notification")
                }

            }
        }
        .onAppear {
            requestAuthorisation()
        }
    }
    
    func requestAuthorisation() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { granted, error in
            self.authorised = granted
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hey 👋"
        content.subtitle = "This is a test notification"
        content.sound = .default
        
        let identifier = UUID().uuidString
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    ContentView()
}
