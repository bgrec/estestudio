import SwiftUI

struct TypesList: View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel

    var types: [String: [Appointment]] {
        Dictionary(
            grouping: appointmentsViewModel.appointments.filter {
                !$0.isOld && !$0.isPast },
            by: { $0.type!}
        )
    }

    var body: some View {
        ForEach(self.types.keys.sorted(), id: \.self) { key in
            TypesRow(typeName: key, appointments: self.types[key]?.sorted() ?? self.userData.appointments.compactMap({$0}))
        }
        .listRowInsets(EdgeInsets())
    }
}
