import Foundation
import CoreData

extension AppointmentCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppointmentCoreData> {
        return NSFetchRequest<AppointmentCoreData>(entityName: "AppointmentCoreData")
    }

    // MARK: - Core Data Managed Object

    @NSManaged public var id: Int32
    @NSManaged public var appointmentTypeID: Int32
    @NSManaged public var calendar: String?
    @NSManaged public var calendarID: Int32
    @NSManaged public var canClientCancel: Bool
    @NSManaged public var canClientReschedule: Bool
    @NSManaged public var classID: Int32
    @NSManaged public var confirmationPage: String?
    @NSManaged public var date: String?
    @NSManaged public var datetime: String?
    @NSManaged public var duration: String?
    @NSManaged public var email: String?
    @NSManaged public var endTime: String?
    @NSManaged public var firstName: String?
    @NSManaged public var formsText: String?
    @NSManaged public var lastName: String?
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var paid: String?
    @NSManaged public var phone: String?
    @NSManaged public var price: String?
    @NSManaged public var time: String?
    @NSManaged public var timezone: String?
    @NSManaged public var type: String?
    @NSManaged public var addonIDs: [Int]?
    @NSManaged public var dateCreated: String?
    @NSManaged public var datetimeCreated: String?
    @NSManaged public var priceSold: String?
    @NSManaged public var amountPaid: String?
    @NSManaged public var category: String?
    @NSManaged public var certificate: Int32
    @NSManaged public var calendarTimezone: String?
    @NSManaged public var canceled: Bool
    //@NSManaged public var labels: [String]?//NSObject?
    //@NSManaged public var forms: [String]?//NSObject?

}
