import Foundation
import CoreData

struct TimeInterval: Identifiable {

    let id = UUID().uuidString
    var text: String
    var timeInterval: Double

    static let `defaultFirst` = Self(text: "1 ora prima", timeInterval: Double(1*60*60))
    static let `defaultEmpty` = Self(text: " ", timeInterval: Double(0))

    static let `defaultList` = [
        (TimeInterval(text: "", timeInterval: Double(0))),
        (TimeInterval(text: "All'ora dell'evento", timeInterval: Double(1))),
        (TimeInterval(text: "5 minuti prima", timeInterval: Double(5*60))),
        (TimeInterval(text: "10 minuti prima", timeInterval: Double(10*60))),
        (TimeInterval(text: "15 minuti prima", timeInterval: Double(15*60))),
        (TimeInterval(text: "30 minuti prima", timeInterval: Double(30*60))),
        (TimeInterval(text: "1 ora prima", timeInterval: Double(1*60*60))),
        (TimeInterval(text: "2 ore prima", timeInterval: Double(2*60*60))),
        (TimeInterval(text: "1 giorno prima", timeInterval: Double(1*24*60*60))),
        (TimeInterval(text: "2 giorni prima", timeInterval: Double(2*24*60*60))),
        (TimeInterval(text: "1 settimana prima", timeInterval: Double(1*7*24*60*60)))
    ]

}

extension TimeInterval: Equatable {}

func == (lhs: TimeInterval, rhs: TimeInterval) -> Bool {
    return lhs.timeInterval == rhs.timeInterval
    
}
