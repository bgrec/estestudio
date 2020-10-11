import SwiftUI

struct ProfileSummary: View {

    @EnvironmentObject private var userData: UserData
    @Environment(\.editMode) private var mode

    var profile: Profile

    var body: some View {
        Form {
            Group {
                Section {
                    HStack {
                        Text("Nome")
                        Text(self.profile.firstName)
                            .font(.headline)
                            .bold()
                    }
                    HStack {
                        Text("Cognome")
                        Text(self.profile.lastName)
                            .font(.headline)
                            .bold()
                    }
                    HStack {
                        Text("Telefono")
                        Text(self.profile.phone)
                            .font(.headline)
                            .bold()
                    }
                    HStack {
                        Text("Email")
                        Text(self.profile.email)
                            .font(.headline)
                            .bold()
                    }
                }
                Section {
                    Toggle(isOn: $userData.profile.prefersNotifications) {
                        Text("Notifiche")
                    }
                    .disabled(true)
                }
            }
            .onTapGesture {
                self.mode?.animation().wrappedValue = .active
            }
        }

    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}

