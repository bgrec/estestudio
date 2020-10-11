import SwiftUI

struct AppointmentDetailEditActionSheet: View {

    @Binding var showingEdit: Bool
    @Binding var isPresented: Bool

    let old: Bool
    let appointment: Appointment

    var body: some View {
        Text("")
            .actionSheet(isPresented: $isPresented, content: {
                if self.old {
                    return ActionSheet(title: Text("Appuntamento non modificabile!"),
                                       buttons: [ .cancel(Text("Chiudi")) ])
                } else {
                    return ActionSheet(title: Text("Vuoi modificare ") + Text(appointment.type!) + Text("?"),
                                       buttons: [ .default(Text("Modifica appuntamento"), action: {
                                        self.showingEdit = true
                                       }),
                                       .destructive(Text("Cancella"), action: {
                                        self.showingEdit = true
                                       }),
                                       .cancel(Text("Chiudi"))])

                }
            })
    }
}

// MARK: - Not used code
/*

 /*
 .actionSheet(isPresented: $showingActionSheet) {
 self.editMenuActionSheet(isOld: self.appointment.isOld || self.appointment.isPast)
 }
 */

 ForEach(appointmentsFiltered()) { appointment in
 AppointmentDetailRow(appointment: appointment)

 .contextMenu {
 AppointmentDetailContextMenu(showingEdit: self.$showingEditAppointment,
 appointment: self.appointment)
 }

 .onTapGesture {
 self.showingActionSheet = true
 }

 }
 .onTapGesture {
 self.showingActionSheet = true
 }

 // MARK: - Action sheet edit appointment menu

 private func editMenuActionSheet(isOld: Bool) -> ActionSheet {
 let actionSheetForOld = ActionSheet(title: Text("Appuntamento non modificabile!"),
 buttons: [ .cancel(Text("Chiudi")) ]
 )

 let actionSheetForModifiable = ActionSheet(title: Text("Vuoi modificare ") + Text(appointment.type!) + Text("?"), buttons:
 [
 .default(Text("Modifica appuntamento"), action: { self.showingEditAppointment = true }),
 .destructive(Text("Cancella"), action: { self.showingEditAppointment = true }),
 .cancel(Text("Chiudi"))
 ])

 if !isOld {
 return actionSheetForModifiable
 } else {
 return actionSheetForOld
 }
 }

 */

