import Foundation
import UserNotifications

struct Profile {
    
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    var prefersNotifications: Bool 
    
    static let `default` = Self(firstName: defaults.string(forKey: "firstName") ?? "",
                                lastName: defaults.string(forKey: "lastName") ?? "",
                                phone: defaults.string(forKey: "phone") ?? "+39",
                                email: defaults.string(forKey: "email") ?? "",
                                prefersNotifications: defaults.bool(forKey: "prefersNotifications"))
    
    init(firstName: String, lastName: String, phone: String, email: String,
         prefersNotifications: Bool) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.prefersNotifications = prefersNotifications
        
        self.verifyAuthorization()

    }
    
    func saveProfile() {

        defaults.set(self.firstName, forKey: "firstName")
        defaults.set(self.lastName, forKey: "lastName")
        defaults.set(self.phone, forKey: "phone")
        defaults.set(self.email, forKey: "email")
        defaults.set(self.prefersNotifications, forKey: "prefersNotifications")
    }
    
    func isComplete() -> Bool {
        if defaults.string(forKey: "firstName") ?? "" == ""
            || defaults.string(forKey: "lastName") ?? "" == ""
            || defaults.string(forKey: "phone") ?? "" == ""
            || defaults.string(forKey: "email") ?? "" == "" {
            
            return false
        } else {
            return true
        }
    }

    private func verifyAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .denied ||
                settings.authorizationStatus == .notDetermined else { return }
            defaults.set(false, forKey: "prefersNotifications")
        }
    }
    
}
