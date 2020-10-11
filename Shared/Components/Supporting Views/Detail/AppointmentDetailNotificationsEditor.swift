import SwiftUI

struct AppointmentDetailNotificationsEdit: View {

    let appointment: Appointment

    @Binding var firstTimeInterval: TimeInterval
    @Binding var secondTimeInterval: TimeInterval

    var body: some View {
        Section(header: Text("Notifiche")) {
            HStack {
                NavigationLink(destination:
                                NotificationAlertTime(timeInterval: self.$firstTimeInterval, appointment: self.appointment, order: 1)
                                .navigationBarTitle("Avviso", displayMode: .inline)) {
                    HStack {
                        VStack {
                            Text("Avviso")
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        VStack {
                            Text(self.firstTimeInterval.text)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
            if self.firstTimeInterval != TimeInterval.defaultEmpty {
                HStack {
                    NavigationLink(destination:
                                    NotificationAlertTime(timeInterval: self.$secondTimeInterval, appointment: self.appointment, order: 2)
                                    .navigationBarTitle("Secondo avviso", displayMode: .inline)) {
                        HStack {
                            VStack {
                                Text("Secondo avviso")
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            VStack {
                                Text(self.secondTimeInterval.text)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                }
            }
        }
    }

}

