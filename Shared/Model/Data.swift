import CoreLocation
import CoreData

let defaults = UserDefaults.standard
let bundle = Bundle.main

// MARK: - Personalisation

let newAppointmentUrl: URL = URL(string: "https://prenotaunappuntamento.as.me/")!
let estestudioUrlString = "http://estestudio.it"
let estestudioUrl: URL = URL(string: estestudioUrlString)!
let estestudioCoordinates = CLLocationCoordinate2D(
    latitude: 46.346150, longitude: 11.058916)

// MARK: - Acuity API Login auth

let username = "16676823"
let password = "c2ad8aaff0b2239ac6760b08c11e981d"

// MARK: - Load JSON from resources file for preview

let appointmentsData: [Appointment?] = load("appointments.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
