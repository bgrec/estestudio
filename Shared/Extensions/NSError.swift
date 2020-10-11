import Foundation

extension NSError {
    static func createError(_ code: Int, description: String) -> NSError {
        return NSError(domain: "com.eSTEstudio.Home",
                       code: 400,
                       userInfo: ["NSLocalizedDescription": description])
    }
}
