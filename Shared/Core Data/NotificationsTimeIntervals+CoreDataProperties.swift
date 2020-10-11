import Foundation
import CoreData

extension NotificationsTimeIntervals: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationsTimeIntervals> {
        return NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
    }

    @NSManaged public var id: UUID
    @NSManaged public var appointmentId: Int32
    @NSManaged public var timeInterval: Double
    @NSManaged public var text: String?
    @NSManaged public var order: Int16

}
