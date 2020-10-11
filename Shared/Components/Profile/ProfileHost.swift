import Foundation
import SwiftUI

struct ProfileHost: View {

    @Environment(\.editMode) private var mode
    @EnvironmentObject private var userData: UserData

    @State var draftProfile = Profile.default
    @State var saveProfile = false

    var body: some View {
        VStack {
            HStack {
                VStack {
                    if self.mode?.wrappedValue == .active {
                        Button("Indietro") {
                            self.draftProfile = self.userData.profile
                            self.mode?.animation().wrappedValue = .inactive

                            self.saveProfile = false
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                VStack {
                    if self.mode?.wrappedValue == .active {
                        Text("")
                    } else {
                        Text("Account")
                            .font(.headline)
                            .bold()
                    }

                }
                .frame(minWidth: 0, maxWidth: .infinity)

                VStack {
                    Button(action: {
                        if self.mode?.animation().wrappedValue == .inactive {
                            self.mode?.animation().wrappedValue = .active
                        } else {
                            self.mode?.animation().wrappedValue = .inactive
                        }

                        self.saveProfile = true
                    }) {
                        //Text(self.mode?.wrappedValue == .active  ? "Conferma" : "Modifica")
                        if self.mode?.wrappedValue == .active {
                            Text("Conferma")
                        } else {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                                .accessibility(label: Text("Modifica"))
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding(.top)

            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: userData.profile)
            } else {
                ProfileEditor(profile: $draftProfile, saveProfile: $saveProfile)
                    .onAppear {
                        self.draftProfile = self.userData.profile
                    }
                    .onDisappear {
                        // hide keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        DispatchQueue.main.async {
                            self.userData.profile = self.draftProfile
                            self.userData.profile.saveProfile()
                        }
                    }
            }
        }
    }

}

// MARK: - Preview

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost().environmentObject(UserData())
    }
}
