import SwiftUI
import CoreData
import EventKit

struct AppointmentDetail: View {

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject private var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var userData: UserData

    @State private var showingEditAppointment = false
    //@State private var showingActionSheet = false

    @State private var firstTimeInterval = TimeInterval.defaultFirst
    @State private var secondTimeInterval = TimeInterval.defaultEmpty

    let appointment: Appointment

    var body: some View {
        List {
            Section {
                ForEach(appointmentsFiltered()) { appointment in
                    AppointmentDetailRow(appointment: appointment)
                }
                .onDelete(perform: {_ in
                    if !(appointment.isOld || appointment.isPast) {
                        self.showingEditAppointment.toggle()
                    }
                })
            }

            Group {
                Section(header: Text(self.sectionHeaderString())) {
                    HStack {
                        Text(appointment.type!)
                            .font(.headline)
                    }
                    HStack {
                        Text("Durata")
                        Text(appointment.duration!)
                        Text("minuti")

                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                }
                if appointment.notes! != "" {
                    Section(header: Text("Note")) {
                        HStack {
                            Text(appointment.notes!)
                                .font(.headline)
                        }
                    }
                }
            }

            Group {
                if !appointment.isOld && !appointment.isPast && userData.profile.prefersNotifications {
                    AppointmentDetailNotificationsEdit(
                        appointment: self.appointment,
                        firstTimeInterval: self.$firstTimeInterval,
                        secondTimeInterval: self.$secondTimeInterval )

                    Section(header: Text("Calendario")) {
                        HStack {
                            Button(action: {
                                // var store = EKEventStore(accessToEntityTypes: .calendar)
                                //let e = LocalEventManager()
                                //e.requestAuthorisation()
                            }) {
                                Text("Aggiungi evento")
                            }

                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    if !(appointment.isOld || appointment.isPast) {
                        self.showingEditAppointment.toggle()
                    }
                }) {
                    Image(systemName: appointment.isOld || appointment.isPast ? "pencil.slash" : "square.and.pencil")
                        .imageScale(.large)
                        .accessibility(label: Text("Modifica"))
                        .padding()
                }
            }
        }

        .onAppear(perform: {
            DispatchQueue.main.async {
                self.fetchTimeIntervals()
            }
        })

        .alert(isPresented: $appointmentsViewModel.showingAlert) {
            Alert(title: Text("Errore"), message: Text(self.appointmentsViewModel.alertText), dismissButton: .default(Text("OK")))
        }

        .sheet(isPresented: $showingEditAppointment,
               onDismiss: {
                //self.presentationMode.wrappedValue.dismiss()
                self.appointmentsViewModel.load(old: false)
               }) {
            SafariView(url: URL(string: self.appointment.confirmationPage ?? estestudioUrlString))
        }

        .listStyle(GroupedListStyle())

        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            //self.presentationMode.wrappedValue.dismiss()
            self.appointmentsViewModel.load(old: false)
        }
    }

}

// MARK: - Detail section header text

extension AppointmentDetail {

    private func sectionHeaderString() -> String {
        let category = appointment.category!
        let calendar = appointment.calendar!
        let calendarWords = calendar.split(separator: " ")
        var found = true

        for word in calendarWords {
            if !category.contains(word) {
                found = false
                break
            }
        }
        return found ? category : category + " con " + calendar
    }

    // MARK: - Filter appointments array by selected appointment

    private func appointmentsFiltered() -> [Appointment] {
        let appointments = self.appointmentsViewModel.appointments
        let appointmentToFilter = self.appointment
        let appointmentsFiltered = appointments.filter { $0.id == appointmentToFilter.id }

        return appointmentsFiltered
    }

    // MARK: - Set time intervals from core data

    private func fetchTimeIntervals() {
        if !self.appointment.isOld && !self.appointment.isPast {
            let timeIntervals = TimeIntervalsCoreData(context: self.managedObjectContext,
                                                      appointment: self.appointment)
            self.firstTimeInterval = timeIntervals.firstTimeInterval()
            self.secondTimeInterval = timeIntervals.secondTimeInterval()
        }
    }

}

// MARK: - Preview

struct AppointmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return AppointmentDetail(appointment: userData.appointments[0]!)
            .environmentObject(userData)
    }
}

// MARK: - Not used code

/*

 /*var appointmentIndex: Int {
 appointmentsViewModel.appointments.compactMap({$0}).firstIndex(where: { $0.id == appointment.id })!
 }*/

 /*.onReceive(self.appointmentsViewModel.$appointments) { appointments in
 if !appointments.contains(self.appointment) {
 self.presentationMode.wrappedValue.dismiss()
 }
 })*/

 /*@FetchRequest(entity: NotificationsTimeIntervals.entity(),
 sortDescriptors: [])
 var notificationTimeIntervals: FetchedResults<NotificationsTimeIntervals>*/

 /* used with fetched request
 let first = self.notificationTimeIntervals.filter({ $0.appointmentId == self.appointment.id && $0.order == 1})
 if !first.isEmpty {
 self.firstTimeInterval = TimeInterval(text: first[0].text ?? TimeInterval.defaultFirst.text, timeInterval: first[0].timeInterval)
 print("here")
 } else {
 self.firstTimeInterval = TimeInterval.defaultFirst
 }

 let second = self.notificationTimeIntervals.filter({ $0.appointmentId == self.appointment.id && $0.order == 2})
 if !second.isEmpty {
 self.secondTimeInterval = TimeInterval(text: second[0].text ?? TimeInterval.defaultEmpty.text, timeInterval: second[0].timeInterval)
 } else {
 self.secondTimeInterval = TimeInterval.defaultEmpty
 }*/
 */

