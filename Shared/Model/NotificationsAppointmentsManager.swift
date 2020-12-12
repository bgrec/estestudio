import Foundation
import CoreData
import SwiftUI

struct NotificationsAppointmentsManager {

    let notificationManager = LocalNotificationManager()

   /* init(appointments: [Appointment]) {
        self.scheduleNotifications(appointments: appointments)
    }*/

    func scheduleNotifications(appointments: [Appointment]) {

        // swiftlint:disable force_cast
        let managedObjectContext = PersistenceController.shared.container.viewContext //(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


        // swiftlint:enable force_cast

        TimeIntervalsCoreData.deleteTimeIntervalsOfMissingAppointments(managedObjectContext: managedObjectContext, appointments: appointments)

        let appointmentsNotifications = Notifications(appointments: appointments)
        notificationManager.notifications = appointmentsNotifications.notifications

        notificationManager.schedule()
        notificationManager.removeNotificationsForDeletedAppointments(appointments: appointments)
        //notificationManager.removeAllPendingNotificationRequests()
        //notificationManager.listScheduledNotifications()
    }

    func removeAll() {
        notificationManager.removeAllPendingNotificationRequests()
    }
}

/*import Foundation
 import UserNotifications

 class NotificationsPreferencesManager: ObservableObject {
 @Published var showingAlert = false
 @Published var authorized = false

 let notificationCenter = UNUserNotificationCenter.current()

 func authorizationStatus() {
 notificationCenter.getNotificationSettings { settings in
 switch settings.authorizationStatus {
 case .denied:
 DispatchQueue.main.async {
 self.showingAlert = true
 }
 case .authorized, .provisional:
 DispatchQueue.main.async {
 self.authorized = true
 }
 case .notDetermined:
 self.notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
 }
 @unknown default:
 break
 }
 }
 }
 }
 */
