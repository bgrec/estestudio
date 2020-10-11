import Foundation
import UserNotifications
import SwiftUI

class LocalNotificationManager {

    var notifications = [Notification]()

    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }

    private func removePendingNotificationRequests(ids: [String]) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ids)
        //removePendingNotificationRequests(withIdentifiers identifiers: [String])
    }

    func removeAllPendingNotificationRequests() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func removeNotificationsForDeletedAppointments(appointments: [Appointment]) {
        var ids: Set<String> = []

        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            for notification in notifications {

                let firstUnderscore = notification.identifier.firstIndex(of: "_") ?? notification.identifier.endIndex
                let identifier = notification.identifier[..<firstUnderscore]

                if !appointments.contains(where: {String($0.id) == identifier}) {
                    ids.insert(String(identifier))
                    ids.insert(String(identifier + "_2"))
                }
            }
            //print(ids)
            self.removePendingNotificationRequests(ids: Array(ids))
        }
    }

    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }

    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }

    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default
            content.badge = 1

            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: false)
            //let trigger = UNLocationNotificationTrigger(triggerWithRegion: region, repeats: false)

            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                //print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
}
