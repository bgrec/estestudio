/*import Foundation

final class Forms: NSSecureCoding {
    func encode(with coder: NSCoder) {
        //
    }

    init?(coder: NSCoder) {
        //
    }


    static var supportsSecureCoding = true
}

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
//@objc(UIColorValueTransformer)
final class FormsTransformer: NSSecureUnarchiveFromDataTransformer {

    // The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: FormsTransformer.self))

    // 2. Make sure `UIColor` is in the allowed class list.
    //override static var allowedTopLevelClasses: [AnyClass] {
      //  return [.self]
    //}

    //Registers the transformer.
    public static func register() {
        let transformer = FormsTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

*/
