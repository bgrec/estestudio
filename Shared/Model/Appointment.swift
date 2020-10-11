import Foundation

// MARK: - AppointmentElement

struct Appointment: Codable, Identifiable {

    let id: Int
    let firstName: String?
    let lastName: String?
    let phone: String?
    let email: String?
    let date: String?
    let time: String?
    let endTime: String?
    let dateCreated: String?
    let datetimeCreated: String?
    let datetime: String?
    let price: String?
    let priceSold: String?
    let paid: String?
    let amountPaid: String?
    let type: String?
    let appointmentTypeID: Int?
    let classID: Int?
    let addonIDs: [Int]?
    let category: String?
    let duration: String?
    let calendar: String?
    let calendarID: Int?
    let certificate: Int?
    let confirmationPage: String?
    let location: String?
    let notes: String?
    let timezone: String?
    let calendarTimezone: String?
    let canceled: Bool?
    let canClientCancel: Bool?
    let canClientReschedule: Bool?
    let formsText: String?
    //let forms: [String]? //[JSONAny]?
    //let labels: [String]? //[JSONAny]?
    
    // MARK: - Init

    init(appoitnmentCoreData: AppointmentCoreData) {

        id = Int(appoitnmentCoreData.id)
        firstName = String.emptyIfNil(appoitnmentCoreData.firstName)
        lastName = String.emptyIfNil(appoitnmentCoreData.lastName)
        phone = String.emptyIfNil(appoitnmentCoreData.phone)
        email = String.emptyIfNil(appoitnmentCoreData.email)
        date = String.emptyIfNil(appoitnmentCoreData.date)
        datetime = String.emptyIfNil(appoitnmentCoreData.datetime)
        time = String.emptyIfNil(appoitnmentCoreData.time)
        endTime = String.emptyIfNil(appoitnmentCoreData.endTime)
        price = String.emptyIfNil(appoitnmentCoreData.price)
        paid = String.emptyIfNil(appoitnmentCoreData.paid)
        type = String.emptyIfNil(appoitnmentCoreData.type)
        appointmentTypeID = Int(appoitnmentCoreData.appointmentTypeID)
        addonIDs = [Int](appoitnmentCoreData.addonIDs ?? [0])
        classID = Int(appoitnmentCoreData.classID)
        duration = String.emptyIfNil(appoitnmentCoreData.duration)
        calendar = String.emptyIfNil(appoitnmentCoreData.calendar)
        calendarID = Int(appoitnmentCoreData.calendarID)
        canClientCancel = Bool(appoitnmentCoreData.canClientCancel)
        canClientReschedule = Bool(appoitnmentCoreData.canClientReschedule)
        location = String.emptyIfNil(appoitnmentCoreData.location)
        confirmationPage = String.emptyIfNil(appoitnmentCoreData.confirmationPage)
        formsText = String.emptyIfNil(appoitnmentCoreData.formsText)
        notes = String.emptyIfNil(appoitnmentCoreData.notes)
        timezone = String.emptyIfNil(appoitnmentCoreData.timezone)
        dateCreated = String.emptyIfNil(appoitnmentCoreData.dateCreated)
        datetimeCreated = String.emptyIfNil(appoitnmentCoreData.datetimeCreated)
        priceSold = String.emptyIfNil(appoitnmentCoreData.priceSold)
        amountPaid = String.emptyIfNil(appoitnmentCoreData.amountPaid)
        category = String.emptyIfNil(appoitnmentCoreData.category)
        certificate = Int(appoitnmentCoreData.certificate)
        calendarTimezone = String.emptyIfNil(appoitnmentCoreData.calendarTimezone)
        canceled = Bool(appoitnmentCoreData.canceled)
        //forms = [String](appoitnmentCoreData.forms ?? [" "])
        //labels = [String](appoitnmentCoreData.labels ?? [" "])
    }
}

extension Appointment: Equatable {}

func == (lhs: Appointment, rhs: Appointment) -> Bool {
    return lhs.id == rhs.id && lhs.datetime == rhs.datetime
}

extension Appointment: Comparable {}

func < (lhs: Appointment, rhs: Appointment) -> Bool {
    return Date(lhs.datetime ?? "") < Date(rhs.datetime ?? "")
}

extension Appointment {

    var isOld: Bool {
        let startOfTheWorkingDay = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date()) ?? Date()
        if Date(self.datetime ?? "2020-01-01T12:00:00+0100") < startOfTheWorkingDay {
            return true
        } else {
            return false
        }
    }

    var isPast: Bool {
        let dateFormatter = DateFormatter()
        let nowString = dateFormatter.string(from: Date())
        let now = Date()
        if Date(self.datetime ?? nowString) < now {
            return true
        } else {
            return false
        }
    }
}
