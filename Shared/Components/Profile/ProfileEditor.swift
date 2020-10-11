import SwiftUI
import UserNotifications

struct ProfileEditor: View {

    @Binding var profile: Profile
    @Binding var saveProfile: Bool

    @State private var showingAlert = false
    @State private var isToggleOn = false

    var body: some View {
        Form {
            Section(header: Text("Dati inseriti in conferma appuntamento")
                        .font(.subheadline)) {
                HStack {
                    Text("Nome").bold()
                    Divider()
                    TextField("Nome", text: $profile.firstName)
                }
                HStack {
                    Text("Cognome").bold()
                    Divider()
                    TextField("Cognome", text: $profile.lastName)
                }
                HStack {
                    Text("Telefono").bold()
                    Divider()
                    TextField("Telefono", text: $profile.phone)
                }
                HStack {
                    Text("Email").bold()
                    Divider()
                    TextField("Email", text: $profile.email)
                }
            }
            Section(header: Text("Riceverai un avviso prima del appuntamento")
                        .font(.subheadline)) {
                Toggle(isOn: $isToggleOn) {
                    Text("Notifiche")
                }
                .onTapGesture {
                    self.notificationsAuthorizationStatus()
                }
            }
        }.onAppear(perform: {
            self.isToggleOn = self.profile.prefersNotifications
        })
        .onDisappear(perform: {
            if self.saveProfile == true {
                self.profile.prefersNotifications = self.isToggleOn
            }
        })
        .alert(isPresented: self.$showingAlert) {
            Alert(title: Text("Notifiche disabilitate"),
                  message: Text("Abilitare le notifiche da impostazioni"),
                  primaryButton: .default(Text("Impostazioni"), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                  }),
                  secondaryButton: .default(Text("OK"))
            )}
    }

}

extension ProfileEditor {

    private func notificationsAuthorizationStatus() {

        if isToggleOn == false {
            let notificationCenter =  UNUserNotificationCenter.current()

            notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            }

            notificationCenter.getNotificationSettings { settings in
                guard settings.authorizationStatus == .denied else { return }

                self.showingAlert = true
                self.isToggleOn = false
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default), saveProfile: .constant(false))
    }
}

