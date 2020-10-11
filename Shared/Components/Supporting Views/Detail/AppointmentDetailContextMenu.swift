import SwiftUI

// MARK: - Not used code
/*
 .contextMenu {
 AppointmentDetailContextMenu(showingEdit: self.$showingEditAppointment,
 appointment: self.appointment)
 }
 */

struct AppointmentDetailContextMenu: View {
    @Binding var showingEdit: Bool
    let appointment: Appointment

    var body: some View {
        VStack {
            if appointment.isOld || appointment.isPast {
                Button(action: {
                }) {
                    Text("Appuntamento non modificabile")
                    Image(systemName: "pencil.slash")
                }
            } else {
                Button(action: {
                    self.showingEdit = true
                }) {
                    Text("Modifica")
                    Image(systemName: "square.and.pencil")
                }
                Button(action: {
                    self.showingEdit = true
                }) {
                    Text("Cancella")
                    Image(systemName: "trash")
                }
            }
        }
    }

}

