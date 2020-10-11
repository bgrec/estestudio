import Foundation

import SwiftUI

struct AppointmentCalendarImageView: View {

    var appointment: Appointment

    var body: some View {
        VStack {
            if appointment.isOld {
                Image(systemName: "calendar.badge.exclamationmark")
                    .foregroundColor(.red)
            } else if appointment.isPast {
                Image(systemName: "calendar.badge.exclamationmark")
                    .foregroundColor(.orange)
            } else {
                Image(systemName: "calendar.badge.clock")
            }
        }
        .imageScale(.large)
        .padding()
    }
}
