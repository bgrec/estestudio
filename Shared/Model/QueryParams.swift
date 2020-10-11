import Foundation
import CryptoKit

// MARK: Http request query parameters

struct QueryParams {

    var old: Bool
    let urlComponents = URLComponents()
    let scheme = "https"
    let host = "acuityscheduling.com"
    let path = "/api/v1/appointments.json"
    var queryItems = [URLQueryItem(name: "email", value: defaults.string(forKey: "email") ?? ""),
                      URLQueryItem(name: "firstName", value: defaults.string(forKey: "firstName") ?? "")]

    let debugKey = "f8f20af39adfd5fd8eae5e0c452a37595007ecfb430b2727ba45ab95e6de83b9"

    init(old: Bool) {
        let minDate = MinDate(old: old)
        self.old = old
        self.queryItems.append(URLQueryItem(name: "minDate", value: minDate.date()))

        let debug = DevelopmentDebug(debugEmail: defaults.string(forKey: "email") ?? "").hashedString

        if debug == debugKey {
            self.queryItems = [URLQueryItem(name: "max", value: "150")]
            self.queryItems.append(URLQueryItem(name: "minDate", value: minDate.date()))
        }
    }
}

// MARK: Start date of appointments download

struct MinDate {
    
    var old: Bool

    func date() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        if old {
            //To-do check january
            let oldDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? now
            return dateFormatter.string(from: oldDate)
        } else {
            return dateFormatter.string(from: now)
        }
    }
}

// MARK: Appointments complete list debbuging

struct DevelopmentDebug {

    var hashedString: String

    init(debugEmail: String) {
        let inputString = debugEmail
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)

        self.hashedString = hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
