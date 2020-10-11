import CoreData
import SwiftUI

struct NotificationAlertTime: View {

    @Environment(\.colorScheme) var colorScheme
    @Binding var timeInterval: TimeInterval

    let timeIntervals = TimeInterval.defaultList
    let appointment: Appointment
    let order: Int

    var body: some View {
        List {
            Section {
                HStack {
                    Text("Nessuno")
                    AlertTimeRows(selectedTimeIterval: self.$timeInterval, timeInterval: self.timeIntervals[0],
                                  appointment: self.appointment, order: order)
                }
            }
            Section {
                ForEach(self.timeIntervals[1...]) { timeInterval in
                    AlertTimeRows(selectedTimeIterval: self.$timeInterval, timeInterval: timeInterval,
                                  appointment: self.appointment, order: self.order)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }

}

private struct AlertTimeRows: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode

    @Binding var selectedTimeIterval: TimeInterval

    var timeInterval: TimeInterval
    let appointment: Appointment
    let order: Int

    var body: some View {
        Button(action: {
            self.selectedTimeIterval = self.timeInterval
            let timeIntervals = TimeIntervalsCoreData(context: self.managedObjectContext, appointment: self.appointment)
            timeIntervals.updateTimeIntervalsCoreData(order: self.order, timeInterval: self.timeInterval)

            self.presentationMode.wrappedValue.dismiss()

        }) {
            HStack {
                Text(timeInterval.text)
                    .foregroundColor(.primary)
                Spacer()
                if timeInterval == selectedTimeIterval {
                    Image(systemName: "checkmark")
                        .imageScale(.large)
                        .foregroundColor(.red)
                }
            }
        }
    }

}

// MARK: - Not used code

/*let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
 let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
 fetchRequest.sortDescriptors = [sortDescriptor]

 let predicate = NSPredicate(format: "appointmentId == %i AND order == %u", Int32(self.appointment.id), Int16(self.order))
 fetchRequest.predicate = predicate
 //fetchRequest.returnsObjectsAsFaults = false
 //fetchRequest.fetchLimit = 1
 do {
 let timeIntervals = try self.managedObjectContext.fetch(fetchRequest) as [NotificationsTimeIntervals]
 //print(timeIntervals.count)
 let timeIntervalUpdated = timeIntervals[0] as NotificationsTimeIntervals
 timeIntervalUpdated.text = self.timeInterval.text
 timeIntervalUpdated.timeInterval = self.timeInterval.timeInterval
 do {
 try self.managedObjectContext.save()
 } catch {
 print(error)
 }
 print("saved")
 } catch {
 print("notsaved")
 print(error.localizedDescription)
 }
 print(self.timeInterval)*/

/*@Environment(\.managedObjectContext) var managedObjectContext
 @FetchRequest(entity: NotificationsTimeIntervals.entity(),
 sortDescriptors: [])
 var notificationTimeIntervals: FetchedResults<NotificationsTimeIntervals>*/

/*ZStack {
 Image(colorScheme == .dark ? "White Watermark" : "Dark_pdf2")
 .resizable()
 .scaledToFit()
 .aspectRatio(contentMode: .fit)
 .luminanceToAlpha()
 }
 }*/

