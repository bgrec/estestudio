import SwiftUI

struct AppointmentsScrollView: View {

    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var appointmentsViewModel: AppointmentsViewModel

    @State private var showingProfile = false

    var body: some View {
        List {
            EsteStudioWebView()
            TypesList()
        }
        .listStyle(GroupedListStyle())

        .navigationBarTitle("Appuntamenti", displayMode: .automatic)
        /*.toolbar {
         ToolbarItem {
         HStack {
         VStack {
         ProgressView()
         }.multilineTextAlignment(.leading)
         VStack {
         self.profileButton
         }
         }
         }
         }*/
        .navigationBarItems(leading: ActivityIndicator(shouldAnimate: self.$appointmentsViewModel.loading), trailing: self.profileButton)
        .sheet(isPresented: self.$showingProfile,
               onDismiss: { self.appointmentsViewModel.load(old: false) }) {
            ProfileHost()
                .environmentObject(self.userData)
        }
        .alert(isPresented: self.$appointmentsViewModel.showingAlert) {
            Alert(title: Text("Errore"), message: Text(self.appointmentsViewModel.alertText), dismissButton: .default(Text("OK"))
            )}
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.appointmentsViewModel.load(old: false)
        }
        .onAppear {
            //self.appointmentsViewModel.load(old: false)
        }
    }
}

// MARK: - Buttons
extension AppointmentsScrollView {

    private var profileButton: some View {
        Button(action: {
            self.showingProfile.toggle()
        }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("Profilo"))
                .padding()
        }
    }
}

