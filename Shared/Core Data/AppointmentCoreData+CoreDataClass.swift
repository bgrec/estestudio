import Foundation
import CoreData

@objc(AppointmentCoreData)
public class AppointmentCoreData: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case addonIDs
        case appointmentTypeID
        case calendar
        case calendarID
        case canClientCancel
        case canClientReschedule
        case classID
        case confirmationPage
        case date
        case datetime
        case duration
        case email
        case endTime
        case firstName
        case formsText
        case id
        case lastName
        case location
        case notes
        case paid
        case phone
        case price
        case time
        case timezone
        case type
        case dateCreated
        case datetimeCreated
        case priceSold
        case amountPaid
        case category
        case certificate
        case calendarTimezone
        case canceled
        //case forms
        //case labels
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(addonIDs, forKey: .addonIDs)
        try container.encode(appointmentTypeID, forKey: .appointmentTypeID)
        try container.encode(calendar, forKey: .calendar)
        try container.encode(calendarID, forKey: .calendarID)
        try container.encode(canClientCancel, forKey: .canClientCancel)
        try container.encode(canClientReschedule, forKey: .canClientReschedule)
        try container.encode(classID, forKey: .classID)
        try container.encode(confirmationPage, forKey: .confirmationPage)
        try container.encode(date, forKey: .date)
        try container.encode(datetime, forKey: .datetime)
        try container.encode(duration, forKey: .duration)
        try container.encode(email, forKey: .email)
        try container.encode(endTime, forKey: .endTime)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(id, forKey: .id)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(location, forKey: .location)
        try container.encode(notes, forKey: .notes)
        try container.encode(paid, forKey: .paid)
        try container.encode(price, forKey: .price)
        try container.encode(time, forKey: .time)
        try container.encode(timezone, forKey: .timezone)
        try container.encode(type, forKey: .type)
        try container.encode(formsText, forKey: .formsText)
        try container.encode(dateCreated, forKey: .dateCreated)
        try container.encode(datetimeCreated, forKey: .datetimeCreated)
        try container.encode(priceSold, forKey: .priceSold)
        try container.encode(amountPaid, forKey: .amountPaid)
        try container.encode(category, forKey: .category)
        try container.encode(certificate, forKey: .certificate)
        try container.encode(calendarTimezone, forKey: .calendarTimezone)
        try container.encode(canceled, forKey: .canceled)
        //try container.encode(forms, forKey: .forms)
        //try container.encode(labels, forKey: .labels)

    }

    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "AppointmentCoreData", in: managedObjectContext) else {
            fatalError("Failed to decode Appointment")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.addonIDs = try container.decodeIfPresent([Int].self, forKey: .addonIDs) ?? [0]
        self.appointmentTypeID = try container.decodeIfPresent(Int32.self, forKey: .appointmentTypeID) ?? 0
        self.calendarID = try container.decodeIfPresent(Int32.self, forKey: .calendarID) ?? 0
        self.calendar = try container.decodeIfPresent(String.self, forKey: .calendar)
        self.canClientCancel = try container.decodeIfPresent(Bool.self, forKey: .canClientCancel) ?? true
        self.canClientReschedule = ((try container.decodeIfPresent(Bool.self, forKey: .canClientReschedule)) != nil)
        self.classID = try container.decodeIfPresent(Int32.self, forKey: .classID) ?? 0
        self.confirmationPage = try container.decodeIfPresent(String.self, forKey: .confirmationPage)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.datetime = try container.decodeIfPresent(String.self, forKey: .datetime)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.endTime = try container.decodeIfPresent(String.self, forKey: .endTime)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.id = try container.decodeIfPresent(Int32.self, forKey: .id)!
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        self.paid = try container.decodeIfPresent(String.self, forKey: .paid)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.formsText = try container.decodeIfPresent(String.self, forKey: .formsText)
        self.dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated)
        self.datetimeCreated = try container.decodeIfPresent(String.self, forKey: .datetimeCreated)
        self.priceSold = try container.decodeIfPresent(String.self, forKey: .priceSold)
        self.amountPaid = try container.decodeIfPresent(String.self, forKey: .amountPaid)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.certificate = try container.decodeIfPresent(Int32.self, forKey: .certificate) ?? 0
        self.calendarTimezone = try container.decodeIfPresent(String.self, forKey: .calendarTimezone)
        self.canceled = try container.decodeIfPresent(Bool.self, forKey: .canceled) ?? false
        //self.forms = try container.decodeIfPresent([String].self, forKey: .forms)
        //self.labels = try container.decodeIfPresent([String].self, forKey: .labels)
    }
}
