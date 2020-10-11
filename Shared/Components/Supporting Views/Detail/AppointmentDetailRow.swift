import SwiftUI

struct AppointmentDetailRow: View {

    var appointment: Appointment

    var body: some View {
        HStack {
            AppointmentCalendarImageView(appointment: appointment)

            VStack(alignment: .leading) {
                HStack {
                    Text(appointment.date!)
                        .font(.title2)
                }
                Divider()
                HStack {
                    Text(appointment.time!)
                        .font(.title2)
                }
            }
            .padding()
        }
    }

}

