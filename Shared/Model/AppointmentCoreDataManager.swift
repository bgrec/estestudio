import Foundation
import CoreData

typealias FetchItemsCompletionBlock = (_ success: Bool, _ error: NSError?) -> Void

// MARK: - AppointmentCoreDataControllerProtocol

protocol AppointmentCoreDataControllerProtocol {
    var items: [Appointment?] { get }
    func fetchItems(old: Bool, _ completionBlock: @escaping FetchItemsCompletionBlock)
}

extension AppointmentCoreDataControllerProtocol {
    var items: [Appointment?] {
        return items
    }
}

// MARK: - AppointmentCoreDataController

class AppointmentCoreDataManager {

    static let shared = AppointmentCoreDataManager()
    private let persistentContainer: NSPersistentContainer = PersistentStore.shared.persistentContainer
    private static let entityName = "AppointmentCoreData"
    private var fetchItemsCompletionBlock: FetchItemsCompletionBlock?

    var items: [Appointment?] = []

    /*init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }*/
    private init() {}


    func fetchItems(old: Bool, _ completionBlock: @escaping FetchItemsCompletionBlock) {
        fetchItemsCompletionBlock = completionBlock
        loadData(old: old)
    }
}

// MARK: - AppointmentCoreDataController extensions

private extension AppointmentCoreDataManager {
    func parse(_ jsonData: Data) -> Bool {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }

            self.clearStorage()

            // Parse JSON data
            let managedObjectContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            _ = try decoder.decode([AppointmentCoreData].self, from: jsonData)

            if managedObjectContext.hasChanges {
                try managedObjectContext.save()
            }

            return true
        } catch let error {
            print(error)
            return false
        }
    }

    private func fetchFromStorage() -> [AppointmentCoreData]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AppointmentCoreData>(entityName: AppointmentCoreDataManager.entityName)
        let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
        //let sortDescriptor2 = NSSortDescriptor(key: "datetime", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1]
        do {
            let appointments = try managedObjectContext.fetch(fetchRequest)
            return appointments
        } catch let error {
            print(error)
            return nil
        }
    }

    private func clearStorage() {
        
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AppointmentCoreDataManager.entityName)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let appointments = try managedObjectContext.fetch(fetchRequest)
                for appointment in appointments {
                    // swiftlint:disable force_cast
                    managedObjectContext.delete(appointment as! NSManagedObject)
                    // swiftlint:enable force_cast
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }

    static func initViewModels(_ appointments: [AppointmentCoreData?]) -> [Appointment?] {
        return appointments.map { appointment in
            if let appointment = appointment {
                return Appointment(appoitnmentCoreData: appointment)
            } else {
                return nil
            }
        }
    }

    private func loginAuth(username: String, password: String) -> String {
        let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        return base64LoginData
    }

    private func urlComponent(queryParams: QueryParams) -> URLComponents {
        var urlComponents = queryParams.urlComponents
        urlComponents.scheme = queryParams.scheme
        urlComponents.host = queryParams.host
        urlComponents.path = queryParams.path
        urlComponents.queryItems = queryParams.queryItems
        return urlComponents
    }

    private func loadData(old: Bool) {

        let urlComponents = urlComponent(queryParams: QueryParams(old: old))

        guard let url = urlComponents.url
            else {
                fetchItemsCompletionBlock?(false, nil)
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(loginAuth(username: username, password: password))", forHTTPHeaderField: "Authorization")

        //let config = URLSessionConfiguration.default
        //config.waitsForConnectivity = true

        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [weak self] (data, _, error) in
            guard let strongSelf = self else { return }
            guard let jsonData = data, error == nil else {
                DispatchQueue.main.async {
                    strongSelf.fetchItemsCompletionBlock?(false, nil)
                }
                return
            }
            if strongSelf.parse(jsonData) {
                if let appointments = strongSelf.fetchFromStorage() {
                    let newAppointments = AppointmentCoreDataManager.initViewModels(appointments)
                    //strongSelf.items?.append(contentsOf: newAppointmentsPage)
                    strongSelf.items = newAppointments
                }
                DispatchQueue.main.async {
                    strongSelf.fetchItemsCompletionBlock?(true, nil)
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.fetchItemsCompletionBlock?(false, NSError.createError(0, description: "JSON parsing error"))
                }
            }
        }
        task.resume()
    }
}
