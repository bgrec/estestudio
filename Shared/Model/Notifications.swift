import Foundation
import CoreData
import SwiftUI

struct Notifications {


    var notifications = [Notification]()

    init(appointments: [Appointment]) {
        self.notifications = createNotifications(appointments: appointments)
    }

    private func createNotifications(appointments: [Appointment]) -> [Notification] {

        // swiftlint:disable force_cast
        let managedObjectContext = PersistenceController.shared.container.viewContext
        //(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // swiftlint:enable force_cast

        var notifications = [Notification]()

        appointments.forEach { appointment in

            if !appointment.isPast {

                let id = String(appointment.id)

                guard let title = appointment.type else { return }
                guard let datetime = appointment.datetime else { return }
                let body = notificationBody(datetime: datetime)

                let timeIntervals = TimeIntervalsCoreData(context: managedObjectContext, appointment: appointment)
                let timeIntervalModifiers = timeIntervals.timeIntervalModifiers()

                for (counter, timeInterval) in timeIntervalModifiers.enumerated() {
                    let dateComponents = componentsAppointmentDateTime(datetime: datetime, timeInterval: Double(timeInterval) )
                    var suffix = ""
                    if counter >= 1 {
                        suffix = "_" + String(counter + 1)
                    }
                    let notification = Notification(id: id + suffix, title: title, body: body,
                                                    datetime: dateComponents)
                    notifications.append(notification)
                }
            }
        }
        return notifications
    }

    private func componentsAppointmentDateTime(datetime: String, timeInterval: Double) -> DateComponents {
        let appointmentDateTime = Date(datetime)

        let modifiedDate = Date(timeInterval: -timeInterval, since: appointmentDateTime)

        let calendar = Calendar.current
        let timeZone = TimeZone.current
        let year = calendar.component(.year, from: modifiedDate)
        let month = calendar.component(.month, from: modifiedDate)
        let day = calendar.component(.day, from: modifiedDate)
        let hour = calendar.component(.hour, from: modifiedDate)
        let minute = calendar.component(.minute, from: modifiedDate)

        let modifiedAppointmentDateComponents = DateComponents(
            calendar: calendar, timeZone: timeZone, year: year, month: month, day: day, hour: hour, minute: minute)

        return modifiedAppointmentDateComponents

    }

    private func notificationBody(datetime: String) -> String {

        let appointmentDateTime = Date(datetime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let body = formatter.string(from: appointmentDateTime)

        return body
    }

}

// MARK: - Notification

struct Notification {
    
    var id: String
    var title: String
    var body: String
    var datetime: DateComponents

    init(id: String, title: String, body: String, datetime: DateComponents) {
        self.id = id
        self.title = title
        self.body = body
        self.datetime = datetime
    }
}
/*
 let snoozeAction = UNNotificationAction(identifier: "Complete", title: "Mark as Complete", options: [])
 let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
 let category = UNNotificationCategory(identifier: categoryIdentifier,
 actions: [snoozeAction, deleteAction],
 intentIdentifiers: [],
 options: [])

 notificationCenter.setNotificationCategories([category])
 }
 }*/
