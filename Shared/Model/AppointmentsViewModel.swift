import Foundation
import SwiftUI
import CoreData
import Combine

class AppointmentsViewModel: ObservableObject {
    
    @Published var appointments = [Appointment]()
    @Published var loading = false
    @Published var alertText = String()
    @Published var showingAlert = false


    static let shared = AppointmentsViewModel()

    private var appointmentController: AppointmentCoreDataManager = AppointmentCoreDataManager.shared //AppointmentCoreDataManager(persistentContainer: PersistentStore.shared.persistentContainer)
    //private var appointmentsNotificationManager: AppointmentsNotificationManager

    // swiftlint:disable force_cast
    /*init() {
        self.appointmentController = AppointmentCoreDataManager(persistentContainer: PersistentStore.shared.persistentContainer)
    }*/
    // swiftlint:enable force_cast

    private init() {}
    func load(old: Bool) {
        if Profile.default.isComplete() && !self.loading {
            self.fetch(old: old)
        }
    }

    private func fetch(old: Bool) {
        self.loading = true
        appointmentController.fetchItems(old: old) { [weak self] (success, error) in
            guard let strongSelf = self else {
                self?.loading = false
                self?.showingAlert = true
                self?.alertText = "Errore interno "
                return
            }
            if !success {
                DispatchQueue.main.async {
                    if error != nil {
                        strongSelf.showingAlert = true
                        strongSelf.alertText = "Errore app"
                    } else {
                        strongSelf.showingAlert = true
                        strongSelf.alertText = "Errore di conessione"

                        strongSelf.retryLoad()
                    }
                    self?.loading = false
                }
            } else {
                strongSelf.showingAlert = false
                DispatchQueue.main.async {
                    strongSelf.appointments = strongSelf.appointmentController.items.compactMap({$0}).sorted()
                    print(strongSelf.appointments.count )
                    strongSelf.loading = false
                }
            }
        }
    }

    private func retryLoad() {
        NetStatus.shared.startMonitoring()
        NetStatus.shared.netStatusChangeHandler = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [unowned self] in
                if NetStatus.shared.isConnected {
                    self.load(old: false)
                    NetStatus.shared.stopMonitoring()
                } else {
                    NetStatus.shared.stopMonitoring()
                    NetStatus.shared.startMonitoring()
                }
            }
        }
    }
    
}
