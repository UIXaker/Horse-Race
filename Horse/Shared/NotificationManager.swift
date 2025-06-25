import Foundation
import UserNotifications

struct NotificationManager {
    static func requestPushAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("Failed to request notifications permission: \(error)")
            } else {
                print("Push permission granted: \(granted)")
            }
        }
    }
}
