/*import Foundation

 final class AddonIDs: NSSecureCoding {

 static var supportsSecureCoding = true
 }

 // 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
 //@objc(UIColorValueTransformer)
 final class AddonIDsTransformer: NSSecureUnarchiveFromDataTransformer {

 // The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
 static let name = NSValueTransformerName(rawValue: String(describing: AddonIDsTransformer.self))

 // 2. Make sure `UIColor` is in the allowed class list.
 override static var allowedTopLevelClasses: [AnyClass] {
 return [Int.self]
 }

 //Registers the transformer.
 public static func register() {
 let transformer = AddonIDsTransformer()
 ValueTransformer.setValueTransformer(transformer, forName: name)
 }
 }
 */

