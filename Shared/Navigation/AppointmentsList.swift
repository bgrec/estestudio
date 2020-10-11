import SwiftUI

struct AppointmentsList: View {

    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var appointmentsViewModel: AppointmentsViewModel

    var body: some View {
        List {
            Section {
                Toggle(isOn: $userData.showOld) {
                    Text("Eventi passati")
                        .foregroundColor(.secondary)
                }
                .disabled(appointmentsViewModel.loading)
                .onTapGesture {
                    //if appointmentsViewModel.loading {
                        //print("loading")
                   // } else {
                    if !userData.showOld {
                        self.appointmentsViewModel.load(old: true)}
                }
                //}
            }
            ForEach(appointmentsViewModel.appointments) { appointment in
                NavigationLink(
                    destination: AppointmentDetail(appointment: appointment)
                ) {
                    AppointmentListRow(appointment: appointment)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Elenco appuntamenti", displayMode: .inline)
        .navigationBarItems(leading: ActivityIndicator(shouldAnimate: $appointmentsViewModel.loading))
        .alert(isPresented: $appointmentsViewModel.showingAlert) {
            Alert(title: Text("Errore"), message: Text(self.appointmentsViewModel.alertText), dismissButton: .default(Text("OK")))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.userData.showOld = false
        }
    }
}

// MARK: - Preview
struct AppointmentsList_Previews: PreviewProvider {
    static var previews: some View {
        //ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
        AppointmentsList()
            .environmentObject(UserData())
            .environmentObject(AppointmentsViewModel.shared)
        //.previewDevice(PreviewDevice(rawValue: deviceName))
        //.previewDisplayName(deviceName)
        //}
    }
}

