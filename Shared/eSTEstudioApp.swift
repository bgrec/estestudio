import CoreData
import Foundation
import SwiftUI

#if APPCLIP
import AppClip
import CoreLocation
#endif

@main
struct eSTEstudioApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var appointmentsViewModel = AppointmentsViewModel.shared
    @StateObject private var appState = AppState()
    @StateObject private var userData = UserData()
    
    let persistenceController = PersistenceController.shared
    
    
    #if !APPCLIP
    //@StateObject private var store = Store()
    #endif
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            #if APPCLIP
            //NavigationView {
            //    SmoothieMenu()
            //}
            //.environmentObject(model)
            //.onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
            #else
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appointmentsViewModel)
                .environmentObject(userData)
                .environmentObject(appState)
            
            #endif
        }
        
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("\(#function) REPORTS - App change of scenePhase to ACTIVE")
            case .inactive:
                print("\(#function) REPORTS - App change of scenePhase to INACTIVE")
            case .background:
                print("\(#function) REPORTS - App change of scenePhase to BACKGROUND")
                
                let prefersNotifications = defaults.bool(forKey: "prefersNotifications")
                let appointmentsNotificationManager = NotificationsAppointmentsManager()
                if prefersNotifications == true {
                    appointmentsNotificationManager.scheduleNotifications(appointments: self.appointmentsViewModel.appointments)
                } else {
                    appointmentsNotificationManager.removeAll()
                }
                
                savePersistentStore()
                
            @unknown default:
                fatalError("\(#function) REPORTS - fatal error in switch statement for .onChange modifier")
            }
        }
    }
    private func savePersistentStore() {
        persistenceController.save()
    }
    
}

/**class PersistenceManager {
 let persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "MyApplication")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo)")
 }
 })
 return container
 }()
 
 init() {
 let center = NotificationCenter.default
 let notification = UIApplication.willResignActiveNotification
 
 center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
 guard let self = self else { return }
 
 if self.persistentContainer.viewContext.hasChanges {
 try? self.persistentContainer.viewContext.save()
 }
 }
 }
 }
 */
//import SwiftUI
//import CoreData

/*
 class PersistentStore: ObservableObject {
 var context: NSManagedObjectContext { persistentContainer.viewContext }
 
 // One line singleton
 static let shared = PersistentStore()
 // Mark the class private so that it is only accessible through the singleton `shared` static property
 private init() {}
 private let persistentStoreName: String = "estestudio"
 // MARK: - Core Data stack
 lazy var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: persistentStoreName)
 // OR - Include the following line for use with CloudKit - NSPersistentCloudKitContainer
 // let container = NSPersistentCloudKitContainer(name: persistentStoreName)
 // Enable history tracking
 // (to facilitate previous NSPersistentCloudKitContainer's to load as NSPersistentContainer's)
 // (not required when only using NSPersistentCloudKitContainer)
 guard let persistentStoreDescriptions = container.persistentStoreDescriptions.first else {
 fatalError("\(#function): Failed to retrieve a persistent store description.")
 }
 persistentStoreDescriptions.setOption(true as NSNumber,
 forKey: NSPersistentHistoryTrackingKey)
 persistentStoreDescriptions.setOption(true as NSNumber,
 forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error {
 // Replace this implementation with code to handle the error appropriately.
 fatalError("Unresolved error \(error)")
 }
 })
 // Include the following line for use with CloudKit - NSPersistentCloudKitContainer
 //container.viewContext.automaticallyMergesChangesFromParent = true
 // Include the following line for use with CloudKit and to set your merge policy, for example...
 //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
 return container
 }()
 // MARK: - Core Data Saving and "other future" support (such as undo)
 func save() {
 let context = persistentContainer.viewContext
 /*if !context.commitEditing() {
 NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
 }*/
 if context.hasChanges {
 do {
 try context.save()
 } catch {
 // Customize this code block to include application-specific recovery steps.
 //let nserror = error as NSError
 // NSApplication.shared.presentError(nserror)
 NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
 }
 }
 }
 }
 
 
 */ //working
/*
 #if APPCLIP
 func handleUserActivity(_ userActivity: NSUserActivity) {
 guard let incomingURL = userActivity.webpageURL,
 let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
 let queryItems = components.queryItems else {
 return
 }
 if let smoothieID = queryItems.first(where: { $0.name == "smoothie" })?.value {
 model.selectSmoothie(id: smoothieID)
 }
 guard let payload = userActivity.appClipActivationPayload,
 let latitudeValue = queryItems.first(where: { $0.name == "latitude" })?.value,
 let longitudeValue = queryItems.first(where: { $0.name == "longitude" })?.value,
 let latitude = Double(latitudeValue), let longitude = Double(longitudeValue) else {
 return
 }
 let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude,
 longitude: longitude), radius: 100, identifier: "smoothie_location")
 payload.confirmAcquired(in: region) { inRegion, error in
 if let error = error {
 print(error.localizedDescription)
 return
 }
 DispatchQueue.main.async {
 model.applePayAllowed = inRegion
 }
 }
 }
 #endif
 */


/*struct YourSwiftUIStruct_Previews: PreviewProvider {
 static var previews: some View {
 let context = PersistentStore.shared.context
 return YourSwiftUIStruct()
 .environment(\.managedObjectContext, context)
 }
 */

/*@main
 struct SampleApp: App {
 @Environment(\.scenePhase) private var scenePhase
 var body: some Scene {
 WindowGroup {
 MovieList()
 .environment(\.managedObjectContext, persistentContainer.viewContext)
 }
 .onChange(of: scenePhase) { phase in
 switch phase {
 case .active:
 print("active")
 case .inactive:
 print("inactive")
 case .background:
 print("background")
 saveContext()
 }
 }
 }
 var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "SampleApp")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo)")
 }
 })
 return container
 }()
 func saveContext() {
 let context = persistentContainer.viewContext
 if context.hasChanges {
 do {
 try context.save()
 } catch {
 let nserror = error as NSError
 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
 }
 }
 }
 }*/




/*
 
 
 import CoreData
 import Foundation
 import SwiftUI
 
 #if APPCLIP
 import AppClip
 import CoreLocation
 #endif
 
 @main
 struct eSTEstudioApp: App {
 
 @Environment(\.scenePhase) private var scenePhase
 @StateObject private var appointmentsViewModel = AppointmentsViewModel.shared
 @StateObject private var persistentStore = PersistentStore.shared
 
 @StateObject private var appState = AppState()
 @StateObject private var userData = UserData()
 
 
 // @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
 
 #if !APPCLIP
 //@StateObject private var store = Store()
 #endif
 
 @SceneBuilder var body: some Scene {
 WindowGroup {
 //#if APPCLIP
 //NavigationView {
 //    SmoothieMenu()
 //}
 //.environmentObject(model)
 //.onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
 // #else
 Home()
 .environment(\.managedObjectContext, persistentStore.context)
 .environmentObject(appointmentsViewModel)
 .environmentObject(userData)
 .environmentObject(appState)
 
 //#endif
 }
 
 .onChange(of: scenePhase) { phase in
 switch phase {
 case .active:
 print("\(#function) REPORTS - App change of scenePhase to ACTIVE")
 case .inactive:
 print("\(#function) REPORTS - App change of scenePhase to INACTIVE")
 case .background:
 print("\(#function) REPORTS - App change of scenePhase to BACKGROUND")
 
 let prefersNotifications = defaults.bool(forKey: "prefersNotifications")
 let appointmentsNotificationManager = NotificationsAppointmentsManager()
 if prefersNotifications == true {
 appointmentsNotificationManager.scheduleNotifications(appointments: self.appointmentsViewModel.appointments)
 } else {
 appointmentsNotificationManager.removeAll()
 }
 
 savePersistentStore()
 
 @unknown default:
 fatalError("\(#function) REPORTS - fatal error in switch statement for .onChange modifier")
 }
 }
 }
 func savePersistentStore() {
 persistentStore.save()
 }
 
 }
 
 /**class PersistenceManager {
 let persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "MyApplication")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo)")
 }
 })
 return container
 }()
 
 init() {
 let center = NotificationCenter.default
 let notification = UIApplication.willResignActiveNotification
 
 center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
 guard let self = self else { return }
 
 if self.persistentContainer.viewContext.hasChanges {
 try? self.persistentContainer.viewContext.save()
 }
 }
 }
 }
 */
 //import SwiftUI
 //import CoreData
 class PersistentStore: ObservableObject {
 var context: NSManagedObjectContext { persistentContainer.viewContext }
 
 // One line singleton
 static let shared = PersistentStore()
 // Mark the class private so that it is only accessible through the singleton `shared` static property
 private init() {}
 private let persistentStoreName: String = "estestudio"
 // MARK: - Core Data stack
 lazy var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: persistentStoreName)
 // OR - Include the following line for use with CloudKit - NSPersistentCloudKitContainer
 // let container = NSPersistentCloudKitContainer(name: persistentStoreName)
 // Enable history tracking
 // (to facilitate previous NSPersistentCloudKitContainer's to load as NSPersistentContainer's)
 // (not required when only using NSPersistentCloudKitContainer)
 guard let persistentStoreDescriptions = container.persistentStoreDescriptions.first else {
 fatalError("\(#function): Failed to retrieve a persistent store description.")
 }
 persistentStoreDescriptions.setOption(true as NSNumber,
 forKey: NSPersistentHistoryTrackingKey)
 persistentStoreDescriptions.setOption(true as NSNumber,
 forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error {
 // Replace this implementation with code to handle the error appropriately.
 fatalError("Unresolved error \(error)")
 }
 })
 // Include the following line for use with CloudKit - NSPersistentCloudKitContainer
 //container.viewContext.automaticallyMergesChangesFromParent = true
 // Include the following line for use with CloudKit and to set your merge policy, for example...
 //container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
 return container
 }()
 // MARK: - Core Data Saving and "other future" support (such as undo)
 func save() {
 let context = persistentContainer.viewContext
 /*if !context.commitEditing() {
 NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
 }*/
 if context.hasChanges {
 do {
 try context.save()
 } catch {
 // Customize this code block to include application-specific recovery steps.
 //let nserror = error as NSError
 // NSApplication.shared.presentError(nserror)
 NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
 }
 }
 }
 }
 
 /*
 #if APPCLIP
 func handleUserActivity(_ userActivity: NSUserActivity) {
 guard let incomingURL = userActivity.webpageURL,
 let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
 let queryItems = components.queryItems else {
 return
 }
 if let smoothieID = queryItems.first(where: { $0.name == "smoothie" })?.value {
 model.selectSmoothie(id: smoothieID)
 }
 guard let payload = userActivity.appClipActivationPayload,
 let latitudeValue = queryItems.first(where: { $0.name == "latitude" })?.value,
 let longitudeValue = queryItems.first(where: { $0.name == "longitude" })?.value,
 let latitude = Double(latitudeValue), let longitude = Double(longitudeValue) else {
 return
 }
 let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude,
 longitude: longitude), radius: 100, identifier: "smoothie_location")
 payload.confirmAcquired(in: region) { inRegion, error in
 if let error = error {
 print(error.localizedDescription)
 return
 }
 DispatchQueue.main.async {
 model.applePayAllowed = inRegion
 }
 }
 }
 #endif
 */
 
 
 /*struct YourSwiftUIStruct_Previews: PreviewProvider {
 static var previews: some View {
 let context = PersistentStore.shared.context
 return YourSwiftUIStruct()
 .environment(\.managedObjectContext, context)
 }
 */
 
 /*@main
 struct SampleApp: App {
 @Environment(\.scenePhase) private var scenePhase
 var body: some Scene {
 WindowGroup {
 MovieList()
 .environment(\.managedObjectContext, persistentContainer.viewContext)
 }
 .onChange(of: scenePhase) { phase in
 switch phase {
 case .active:
 print("active")
 case .inactive:
 print("inactive")
 case .background:
 print("background")
 saveContext()
 }
 }
 }
 var persistentContainer: NSPersistentContainer = {
 let container = NSPersistentContainer(name: "SampleApp")
 container.loadPersistentStores(completionHandler: { (storeDescription, error) in
 if let error = error as NSError? {
 fatalError("Unresolved error \(error), \(error.userInfo)")
 }
 })
 return container
 }()
 func saveContext() {
 let context = persistentContainer.viewContext
 if context.hasChanges {
 do {
 try context.save()
 } catch {
 let nserror = error as NSError
 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
 }
 }
 }
 }*/
 */
