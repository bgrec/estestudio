import Combine
import Foundation
import CoreData
import SwiftUI

final class UserData: ObservableObject {
    @Published var showOld = false
    @Published var appointments = appointmentsData //only for previews
    @Published var profile = Profile.default
}
