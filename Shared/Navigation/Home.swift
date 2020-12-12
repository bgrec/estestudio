import SwiftUI

struct Home: View {

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel

    @State private var showingNewAppointment = false
    @State private var firstOrNew: FirstOrNew?

    var body: some View {
        TabView(selection: $appState.selectedTab) {

            NavigationView {
                AppointmentsScrollView()
                    .environmentObject(appointmentsViewModel)
            }
            .tabItem {
                Label("Menu", systemImage: appState.selectedTab == Tab.menu.rawValue ? "house.fill" : "house")
                    .accessibility(label: Text("Menu"))
                    .padding()
            }
            .tag(Tab.menu.rawValue)

            NavigationView {
                AppointmentsList()
            }
            .tabItem {
                Label("Elenco", systemImage: appState.selectedTab == Tab.list.rawValue ? "rectangle.grid.1x2.fill" : "rectangle.grid.1x2")
                    .accessibility(label: Text("Elenco appuntamenti"))
                    .padding()
            }
            .tag(Tab.list.rawValue)

            MapView(coordinate: estestudioCoordinates)
                .tabItem {
                    Label("Mappa", systemImage: appState.selectedTab == Tab.map.rawValue ? "location.fill" : "location")
                        .accessibility(label: Text("Mappa"))
                        .padding()
                }
                .tag(Tab.map.rawValue)

            SheetPresenter(isPresenting: self.$showingNewAppointment, content: SafariView(url: newAppointmentUrl))
                .environmentObject(self.appState)
                .tabItem {
                    Label("Nuovo", systemImage: appState.selectedTab == Tab.new.rawValue ? "plus.square" : "plus")
                        .accessibility(label: Text("Nuovo appuntamento"))
                        .padding()
                }
                .tag(Tab.new.rawValue)
        }

        .imageScale(.medium)

        .onChange(of: appState.selectedTab) { selection in
            if selection == 3 {
                self.showingNewAppointment = true
            }
        }

        .onAppear(perform: {
            self.verifyVersionAndReview()
            self.appointmentsViewModel.load(old: false)
            
        })

        .sheet(item: $firstOrNew) { item in
            if item == .first {
                FirstLaunchView()
                    .environmentObject(self.userData)
                    .environmentObject(self.appointmentsViewModel)
            } else if item == .new {
                WhatsNewView()
                    .environmentObject(self.userData)
                    .environmentObject(self.appointmentsViewModel)
            }
        }

    }
}

// MARK: - First/New Launch View

private extension Home {

    private enum FirstOrNew: Hashable, Identifiable {
        case first
        case new
        var id: Int {
            return self.hashValue
        }
    }

    private func verifyVersionAndReview() {
        if AppStoreReviewManager.isFirstLaunch() {
            self.firstOrNew = .first
        } else if AppStoreReviewManager.isNewVersion() {
            self.firstOrNew = .new
        }
        //self.firstOrNew = .new
        AppStoreReviewManager.requestReviewIfAppropiate()
        //defaults.set(0, forKey: "timesLaunched")
    }

    // Tab
    enum Tab: Int {
        case menu = 0
        case list = 1
        case map = 2
        case new = 3
    }
}

// MARK: - Preview

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable force_cast
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let context = PersistenceController.shared.container.viewContext
        // swiftlint:enable force_cast

        return Home().environment(\.managedObjectContext, context)
            .environmentObject(UserData())
            .environmentObject(AppState())
            .environmentObject(AppointmentsViewModel.shared)
    }
}

