import SwiftUI

struct AppointmentListRow: View {
    var appointment: Appointment

    var body: some View {
        VStack {
            HStack {
                AppointmentCalendarImageView(appointment: appointment)
                VStack(alignment: .leading) {
                    HStack {
                        Text(appointment.type!)
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.leading)
                    }
                    Divider()
                    HStack {
                        HStack {
                            Text(appointment.date!)
                        }
                        Spacer()
                        HStack {
                            Text(appointment.time!)
                        }
                    }
                    .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
    }
}

struct AppointmentRow_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return Group {
            AppointmentListRow(appointment: userData.appointments[0]!)
            AppointmentListRow(appointment: userData.appointments[0]!)
        }
        //.previewLayout(.fixed(width: 300, height: 70))
    }
}
