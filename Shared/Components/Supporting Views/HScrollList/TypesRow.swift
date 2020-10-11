import SwiftUI

// MARK: - TypesRow

struct TypesRow: View {

    var typeName: String
    var appointments: [Appointment]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.typeName)
                    .font(.title3)
                    .bold()
                    .padding(.leading)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.appointments) { appointment in
                        if !appointment.isOld && !appointment.isPast {
                            NavigationLink(destination:
                                            AppointmentDetail(appointment: appointment)
                            ) {
                                TypeItem(appointment: appointment)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: - TypeItem

struct TypeItem: View {
    var appointment: Appointment
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(appointment.date!)
                        .bold()
                }
                Divider()
                HStack {
                    Text(appointment.time!)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .overlay( RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
        .padding()
    }
}

// MARK: - Preview

struct TypeRow_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()

        return TypesRow(
            typeName: userData.appointments[0]!.type!,
            appointments: Array(userData.appointments.compactMap({$0}).prefix(0))
        ).environmentObject(userData)
    }
}

