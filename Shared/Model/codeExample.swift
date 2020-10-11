//
//  codeExample.swift
//  eSTEstudio
//
//  Created by Bogdan Grec on 03/05/2020.
//  Copyright © 2020 bgrec. All rights reserved.
//
/*
 
 /*


 /*@FetchRequest(
 entity: NotificationsTimeIntervals.entity(),
 sortDescriptors: []
 //,predicate: NSPredicate(format: "appointmentId == %@", appointment.id )
 )*/
 //var fetchRequest: FetchRequest<NotificationsTimeIntervals>
 //var notificationsTimeIntervals: FetchedResults<NotificationsTimeIntervals>
 
 /*"datetime": "2020-06-08T08:00:00+0200",
 Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
 09/12/2018                        --> MM/dd/yyyy
 09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
 Sep 12, 2:11 PM                   --> MMM d, h:mm a
 September 2018                    --> MMMM yyyy
 Sep 12, 2018                      --> MMM d, yyyy
 Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
 2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
 12.09.18                          --> dd.MM.yy
 10:41:02.112                      --> HH:mm:ss.SSS*/


 
 //Check if the element exist
 if array.contains(where: {$0.name == "foo"}) {
 // it exists, do something
 } else {
 //item could not be found
 }

 //Get the element

 if let foo = array.first(where: {$0.name == "foo"}) {
 // do something with foo
 } else {
 // item could not be found
 }
 //Get the element and its offset

 if let foo = array.enumerated().first(where: {$0.element.name == "foo"}) {
 // do something with foo.offset and foo.element
 } else {
 // item could not be found
 }
 //Get the offset
 if let fooOffset = array.firstIndex(where: {$0.name == "foo"}) {
 // do something with fooOffset
 } else {
 // item could not be found
 }*/

 */
import Foundation
/*class SafariViewController: UIViewController, SFSafariViewControllerDelegate  {
  
    var safariViewControle: SFSafariViewController
    
    
    
    // Called when the initial URL load is complete.
       func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) { }
  
    // Called when the user taps an Action button.
    /*func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        Home()
    }*/
    
    
}
     

struct SafariViewController_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: newAppointmentUrl)
    }
}
*/
/*import Foundation

enum LinkPage: CaseIterable, Identifiable {
    case twitter
    case blog

    var id: String { url.absoluteString }

    var url: URL {
        switch self {
        case .twitter:
            return URL(string: "https://twitter.com/davidy4ng")!
        case .blog:
            return URL(string: "https://david.y4ng.fr")!
        }
    }

    var title: String {
        switch self {
        case .twitter:
            return "Twitter"
        case .blog:
            return "Blog"
        }
    }

    var value: String {
        switch self {
        case .twitter:
            return "@davidy4ng"
        case .blog:
            return "https://david.y4ng.fr"
        }
    }
}*
 
 struct CircleImage: View {
     var image: Image

     var body: some View {
         image
             .clipShape(Circle())
             .overlay(Circle().stroke(Color.white, lineWidth: 4))
             .shadow(radius: 10)
     }
 }
 
 //
 //  HikeDetail.swift
 //  estestudio
 //
 //  Created by Bogdan Grec on 02/05/2020.
 //  Copyright © 2020 bgrec. All rights reserved.
 //

 import Foundation
 import SwiftUI

 struct HikeDetail: View {
     let hike: Hike
     @State var dataToShow = \Hike.Observation.elevation
     
     var buttons = [
         ("Elevation", \Hike.Observation.elevation),
         ("Heart Rate", \Hike.Observation.heartRate),
         ("Pace", \Hike.Observation.pace),
     ]
     
     var body: some View {
         return VStack {
             HikeGraph(hike: hike, path: dataToShow)
                 .frame(height: 200)
             
             HStack(spacing: 25) {
                 ForEach(buttons, id: \.0) { value in
                     Button(action: {
                         self.dataToShow = value.1
                     }) {
                         Text(value.0)
                             .font(.system(size: 15))
                             .foregroundColor(value.1 == self.dataToShow
                                 ? Color.gray
                                 : Color.accentColor)
                             .animation(nil)
                     }
                 }
             }
         }
     }
 }

 struct HikeDetail_Previews: PreviewProvider {
     static var previews: some View {
         HikeDetail(hike: hikeData[0])
     }
 }

 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A view that displays a badge.
 */

 import SwiftUI

 struct Badge: View {
     static let rotationCount = 8
     
     var badgeSymbols: some View {
         ForEach(0..<Badge.rotationCount) { i in
             RotatedBadgeSymbol(
                 angle: .degrees(Double(i) / Double(Badge.rotationCount)) * 360.0)
         }
         .opacity(0.5)
     }
     
     var body: some View {
         ZStack {
             BadgeBackground()
             
             GeometryReader { geometry in
                 self.badgeSymbols
                 .scaleEffect(1.0 / 4.0, anchor: .top)
                 .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
             }
         }
         .scaledToFit()
     }
 }

 struct Badge_Previews: PreviewProvider {
     static var previews: some View {
         Badge()
     }
 }

 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A view that displays the background of a badge.
 */

 import SwiftUI

 struct BadgeBackground: View {
     var body: some View {
         GeometryReader { geometry in
             Path { path in
                 var width: CGFloat = min(geometry.size.width, geometry.size.height)
                 let height = width
                 let xScale: CGFloat = 0.832
                 let xOffset = (width * (1.0 - xScale)) / 2.0
                 width *= xScale
                 path.move(
                     to: CGPoint(
                         x: xOffset + width * 0.95,
                         y: height * (0.20 + HexagonParameters.adjustment)
                     )
                 )
                 
                 HexagonParameters.points.forEach {
                     path.addLine(
                         to: .init(
                             x: xOffset + width * $0.useWidth.0 * $0.xFactors.0,
                             y: height * $0.useHeight.0 * $0.yFactors.0
                         )
                     )
                     
                     path.addQuadCurve(
                         to: .init(
                             x: xOffset + width * $0.useWidth.1 * $0.xFactors.1,
                             y: height * $0.useHeight.1 * $0.yFactors.1
                         ),
                         control: .init(
                             x: xOffset + width * $0.useWidth.2 * $0.xFactors.2,
                             y: height * $0.useHeight.2 * $0.yFactors.2
                         )
                     )
                 }
             }
             .fill(LinearGradient(
                 gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                 startPoint: .init(x: 0.5, y: 0),
                 endPoint: .init(x: 0.5, y: 0.6)
             ))
             .aspectRatio(1, contentMode: .fit)
         }
     }
     static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
     static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
 }

 struct BadgeBackground_Previews: PreviewProvider {
     static var previews: some View {
         BadgeBackground()
     }
 }

 
 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A view that display a symbol in a badge.
 */

 import SwiftUI

 struct BadgeSymbol: View {
     static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)

     var body: some View {
         GeometryReader { geometry in
             Path { path in
                 let width = min(geometry.size.width, geometry.size.height)
                 let height = width * 0.75
                 let spacing = width * 0.030
                 let middle = width / 2
                 let topWidth = 0.226 * width
                 let topHeight = 0.488 * height
                 
                 path.addLines([
                     CGPoint(x: middle, y: spacing),
                     CGPoint(x: middle - topWidth, y: topHeight - spacing),
                     CGPoint(x: middle, y: topHeight / 2 + spacing),
                     CGPoint(x: middle + topWidth, y: topHeight - spacing),
                     CGPoint(x: middle, y: spacing)
                 ])
                 
                 path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                 path.addLines([
                     CGPoint(x: middle - topWidth, y: topHeight + spacing),
                     CGPoint(x: spacing, y: height - spacing),
                     CGPoint(x: width - spacing, y: height - spacing),
                     CGPoint(x: middle + topWidth, y: topHeight + spacing),
                     CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                 ])
             }
             .fill(Self.symbolColor)
         }
     }
 }

 struct BadgeSymbol_Previews: PreviewProvider {
     static var previews: some View {
         BadgeSymbol()
     }
 }

 
 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A single line in the graph.
 */

 import SwiftUI

 struct GraphCapsule: View {
     var index: Int
     var height: CGFloat
     var range: Range<Double>
     var overallRange: Range<Double>
     
     var heightRatio: CGFloat {
         max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15)
     }
     
     var offsetRatio: CGFloat {
         CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
     }
     
     var body: some View {
         Capsule()
             .fill(Color.white)
             .frame(height: height * heightRatio)
             .offset(x: 0, y: height * -offsetRatio)
     }
 }

 struct GraphCapsule_Previews: PreviewProvider {
     static var previews: some View {
         GraphCapsule(index: 0, height: 150, range: 10..<50, overallRange: 0..<100)
     }
 }
 
 
 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The elevation, heart rate, and pace of a hike plotted on a graph.
 */

 import SwiftUI

 func rangeOfRanges<C: Collection>(_ ranges: C) -> Range<Double>
     where C.Element == Range<Double> {
     guard !ranges.isEmpty else { return 0..<0 }
     let low = ranges.lazy.map { $0.lowerBound }.min()!
     let high = ranges.lazy.map { $0.upperBound }.max()!
     return low..<high
 }

 func magnitude(of range: Range<Double>) -> Double {
     return range.upperBound - range.lowerBound
 }

 extension Animation {
     static func ripple(index: Int) -> Animation {
         Animation.spring(dampingFraction: 0.5)
             .speed(2)
             .delay(0.03 * Double(index))
     }
 }

 struct HikeGraph: View {
     var hike: Hike
     var path: KeyPath<Hike.Observation, Range<Double>>
     
     var color: Color {
         switch path {
         case \.elevation:
             return .gray
         case \.heartRate:
             return Color(hue: 0, saturation: 0.5, brightness: 0.7)
         case \.pace:
             return Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
         default:
             return .black
         }
     }
     
     var body: some View {
         let data = hike.observations
         let overallRange = rangeOfRanges(data.lazy.map { $0[keyPath: self.path] })
         let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
         let heightRatio = (1 - CGFloat(maxMagnitude / magnitude(of: overallRange))) / 2

         return GeometryReader { proxy in
             HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                 ForEach(data.indices) { index in
                     GraphCapsule(
                         index: index,
                         height: proxy.size.height,
                         range: data[index][keyPath: self.path],
                         overallRange: overallRange)
                     .colorMultiply(self.color)
                     .transition(.slide)
                     .animation(.ripple(index: index))
                 }
                 .offset(x: 0, y: proxy.size.height * heightRatio)
             }
         }
     }
 }

 struct HikeGraph_Previews: PreviewProvider {
     static var previews: some View {
         Group {
             HikeGraph(hike: hikeData[0], path: \.elevation)
                 .frame(height: 200)
             HikeGraph(hike: hikeData[0], path: \.heartRate)
                 .frame(height: 200)
             HikeGraph(hike: hikeData[0], path: \.pace)
                 .frame(height: 200)
         }
     }
 }

 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A view that displays a rotated version of a badge symbol.
 */

 import SwiftUI

 struct RotatedBadgeSymbol: View {
     let angle: Angle
     
     var body: some View {
         BadgeSymbol()
         .padding(-60)
         .rotationEffect(angle, anchor: .bottom)
     }
 }

 struct RotatedBadgeSymbol_Previews: PreviewProvider {
     static var previews: some View {
         RotatedBadgeSymbol(angle: .init(degrees: 5))
     }
 }

 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The model for a hike.
 */

 import SwiftUI

 struct Hike: Codable, Hashable, Identifiable {
     var name: String
     var id: Int
     var distance: Double
     var difficulty: Int
     var observations: [Observation]

     static var formatter = LengthFormatter()
     
     var distanceText: String {
         return Hike.formatter
             .string(fromValue: distance, unit: .kilometer)
     }

     struct Observation: Codable, Hashable {
         var distanceFromStart: Double
         
         var elevation: Range<Double>
         var pace: Range<Double>
         var heartRate: Range<Double>
     }
 }

 //
 //  HikeView.swift
 //  estestudio
 //
 //  Created by Bogdan Grec on 02/05/2020.
 //  Copyright © 2020 bgrec. All rights reserved.
 //

 import Foundation
 import SwiftUI

 struct HikeView: View {
     var hike: Hike
     @State private var showDetail = false
     
     var transition: AnyTransition {
         let insertion = AnyTransition.move(edge: .trailing)
             .combined(with: .opacity)
         let removal = AnyTransition.scale
             .combined(with: .opacity)
         return .asymmetric(insertion: insertion, removal: removal)
     }
     
     var body: some View {
         VStack {
             HStack {
                 HikeGraph(hike: hike, path: \.elevation)
                     .frame(width: 50, height: 30)
                     .animation(nil)
                 
                 VStack(alignment: .leading) {
                     Text(hike.name)
                         .font(.headline)
                     Text(hike.distanceText)
                 }
                 
                 Spacer()

                 Button(action: {
                     withAnimation {
                         self.showDetail.toggle()
                     }
                 }) {
                     Image(systemName: "chevron.right.circle")
                         .imageScale(.large)
                         .rotationEffect(.degrees(showDetail ? 90 : 0))
                         .scaleEffect(showDetail ? 1.5 : 1)
                         .padding()
                 }
             }

             if showDetail {
                 //HikeDetail(hike: hike)
                  //   .transition(transition)
             }
         }
     }
 }

 struct HikeView_Previews: PreviewProvider {
     static var previews: some View {
         VStack {
             HikeView(hike: hikeData[0])
                 .padding()
             Spacer()
         }
     }
 }

 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 A view that shows a badge for hiking.
 */

 import SwiftUI

 struct HikeBadge: View {
     var name: String
     var body: some View {
         VStack(alignment: .center) {
             Badge()
                 .frame(width: 300, height: 300)
                 .scaleEffect(1.0 / 3.0)
                 .frame(width: 100, height: 100)
             Text(name)
                 .font(.caption)
                 .accessibility(label: Text("Badge for \(name)."))
         }
     }
 }

 struct HikeBadge_Previews: PreviewProvider {
     static var previews: some View {
         HikeBadge(name: "Preview Testing")
     }
 }

 
 
 /*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 Size, position, and other information used to draw a badge.
 */

 import SwiftUI

 struct HexagonParameters {
     struct Segment {
         let useWidth: (CGFloat, CGFloat, CGFloat)
         let xFactors: (CGFloat, CGFloat, CGFloat)
         let useHeight: (CGFloat, CGFloat, CGFloat)
         let yFactors: (CGFloat, CGFloat, CGFloat)
     }
     
     static let adjustment: CGFloat = 0.085
     static let points = [
         Segment(
             useWidth:  (1.00, 1.00, 1.00),
             xFactors:  (0.60, 0.40, 0.50),
             useHeight: (1.00, 1.00, 0.00),
             yFactors:  (0.05, 0.05, 0.00)
         ),
         Segment(
             useWidth:  (1.00, 1.00, 0.00),
             xFactors:  (0.05, 0.00, 0.00),
             useHeight: (1.00, 1.00, 1.00),
             yFactors:  (0.20 + adjustment, 0.30 + adjustment, 0.25 + adjustment)
         ),
         Segment(
             useWidth:  (1.00, 1.00, 0.00),
             xFactors:  (0.00, 0.05, 0.00),
             useHeight: (1.00, 1.00, 1.00),
             yFactors:  (0.70 - adjustment, 0.80 - adjustment, 0.75 - adjustment)
         ),
         Segment(
             useWidth:  (1.00, 1.00, 1.00),
             xFactors:  (0.40, 0.60, 0.50),
             useHeight: (1.00, 1.00, 1.00),
             yFactors:  (0.95, 0.95, 1.00)
         ),
         Segment(
             useWidth:  (1.00, 1.00, 1.00),
             xFactors:  (0.95, 1.00, 1.00),
             useHeight: (1.00, 1.00, 1.00),
             yFactors:  (0.80 - adjustment, 0.70 - adjustment, 0.75 - adjustment)
         ),
         Segment(
             useWidth:  (1.00, 1.00, 1.00),
             xFactors:  (1.00, 0.95, 1.00),
             useHeight: (1.00, 1.00, 1.00),
             yFactors:  (0.30 + adjustment, 0.20 + adjustment, 0.25 + adjustment)
         )
     ]
 }

 //
 //  Checkpoint.swift
 //  estestudio
 //
 //  Created by Bogdan on 24/04/2020.
 //  Copyright © 2020 bgrec. All rights reserved.
 //

 import Foundation
 import MapKit
 import Contacts

 final class Checkpoint: NSObject, MKAnnotation {
  
   let title: String?
   let locationName: String?
   let discipline: String?
   let coordinate: CLLocationCoordinate2D
   
   init(title: String?,
        locationName: String?,
        discipline: String?,
        coordinate: CLLocationCoordinate2D) {
     self.title = title
     self.locationName = locationName
     self.discipline = discipline
     self.coordinate = coordinate
     
     super.init()
      
   }
     var mapItem: MKMapItem? {
       guard let location = locationName else {
         return nil
       }
       
       let addressDict = [CNPostalAddressStreetKey: location]
       let placemark = MKPlacemark(
         coordinate: coordinate,
         addressDictionary: addressDict)
       let mapItem = MKMapItem(placemark: placemark)
       mapItem.name = title
       return mapItem
     }
 }
 */

/*import Foundation

typealias Appointment = [AppointmentElement]

extension Array where Element == Appointment.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Appointment.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func appointmentTask(with url: URL, completionHandler: @escaping (Appointment?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseAppointment(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Appointment>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
*/

/*final class ImageStore {
 typealias ImageDictionary = [String: CGImage]
 fileprivate var images: ImageDictionary = [:]
 fileprivate static var scale = 2
 static var shared = ImageStore()
 func image(name: String) -> Image {
 let index = _guaranteeImage(name: name)
 return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
 }

 static func loadImage(name: String) -> CGImage {
 guard
 let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
 let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
 let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
 else {
 fatalError("Couldn't load image \(name).jpg from main bundle.")
 }
 return image
 }

 fileprivate func _guaranteeImage(name: String) -> ImageDictionary.Index {
 if let index = images.index(forKey: name) { return index }

 images[name] = ImageStore.loadImage(name: name)
 return images.index(forKey: name)!
 }
 /*private func link<Destination: View>(icon: String, label: String, destination: Destination) -> some View {
 return NavigationLink(destination: destination) {
 HStack {
 Image(systemName: icon)
 Text(label)
 }        */
 }*/

/*class ProfileRepository {
 enum Key: String, CaseIterable {
 case name, profileData
 func make(for userID: String) -> String {
 return self.rawValue + "_" + userID
 }
 }
 let userDefaults: UserDefaults

 // MARK: - Lifecycle
 init(userDefaults: UserDefaults = .standard) {
 self.userDefaults = userDefaults
 }

 // MARK: - API
 func storeInfo(forUserID userID: String, name: String, profileData: Data) {
 saveValue(forKey: .name, value: name, userID: userID)
 saveValue(forKey: .profileData, value: profileData, userID: userID)
 }

 func getUserInfo(forUserID userID: String) -> (name: String?, profileData: Data?) {
 let name: String? = readValue(forKey: .name, userID: userID)
 let profileData: Data? = readValue(forKey: .profileData, userID: userID)
 return (name, profileData)
 }

 func removeUserInfo(forUserID userID: String) {
 Key
 .allCases
 .map { $0.make(for: userID) }
 .forEach { key in
 userDefaults.removeObject(forKey: key)
 }
 }
 // MARK: - Private
 private func saveValue(forKey key: Key, value: Any, userID: String) {
 userDefaults.set(value, forKey: key.make(for: userID))
 }
 private func readValue<T>(forKey key: Key, userID: String) -> T? {
 return userDefaults.value(forKey: key.make(for: userID)) as? T
 }
 }


 /* func fetchAppointments() {

 /*let user = "user"
 let password = "password"
 let headers: HTTPHeaders = [.authorization(username: user, password: password)]*/
 //let apikey = (: "test@test.test", password: "testPassword")
 let parameters = ["PMAK-5eb70d620d417d003787d828-b068e1800ff4dec88763f62c4902eae667": "x-api-key"]

 AF.request(acuityApointmentsGetUrl, method: .get, parameters: parameters)
 .validate()
 .responseDecodable(of: [Appointment].self, queue: utilityQueue) { (response) in
 guard let appointmentsData: [Appointment] = response.value else { return }
 debugPrint("Response: \(appointmentsData)")
 }
 }*/



 //
 //  JSONany.swift
 //  eSTEstudio
 //
 //  Created by Bogdan Grec on 06/05/2020.
 //  Copyright © 2020 bgrec. All rights reserved.
 //

 import Foundation
 // MARK: - Encode/decode helpers

 class JSONNull: Codable, Hashable {

 public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
 return true
 }

 public var hashValue: Int {
 return 0
 }

 public func hash(into hasher: inout Hasher) {
 // No-op
 }

 public init() {}

 public required init(from decoder: Decoder) throws {
 let container = try decoder.singleValueContainer()
 if !container.decodeNil() {
 throw DecodingError.typeMismatch(JSONNull.self,
 DecodingError.Context(codingPath: decoder.codingPath,
 debugDescription: "Wrong type for JSONNull"))
 }
 }

 public func encode(to encoder: Encoder) throws {
 var container = encoder.singleValueContainer()
 try container.encodeNil()
 }
 }

 class JSONCodingKey: CodingKey {
 let key: String

 required init?(intValue: Int) {
 return nil
 }

 required init?(stringValue: String) {
 key = stringValue
 }

 var intValue: Int? {
 return nil
 }

 var stringValue: String {
 return key
 }
 }

 class JSONAny: Codable {

 let value: Any

 static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
 let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
 return DecodingError.typeMismatch(JSONAny.self, context)
 }

 static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
 let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
 return EncodingError.invalidValue(value, context)
 }

 static func decode(from container: SingleValueDecodingContainer) throws -> Any {
 if let value = try? container.decode(Bool.self) {
 return value
 }
 if let value = try? container.decode(Int64.self) {
 return value
 }
 if let value = try? container.decode(Double.self) {
 return value
 }
 if let value = try? container.decode(String.self) {
 return value
 }
 if container.decodeNil() {
 return JSONNull()
 }
 throw decodingError(forCodingPath: container.codingPath)
 }

 static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
 if let value = try? container.decode(Bool.self) {
 return value
 }
 if let value = try? container.decode(Int64.self) {
 return value
 }
 if let value = try? container.decode(Double.self) {
 return value
 }
 if let value = try? container.decode(String.self) {
 return value
 }
 if let value = try? container.decodeNil() {
 if value {
 return JSONNull()
 }
 }
 if var container = try? container.nestedUnkeyedContainer() {
 return try decodeArray(from: &container)
 }
 if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
 return try decodeDictionary(from: &container)
 }
 throw decodingError(forCodingPath: container.codingPath)
 }

 static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
 if let value = try? container.decode(Bool.self, forKey: key) {
 return value
 }
 if let value = try? container.decode(Int64.self, forKey: key) {
 return value
 }
 if let value = try? container.decode(Double.self, forKey: key) {
 return value
 }
 if let value = try? container.decode(String.self, forKey: key) {
 return value
 }
 if let value = try? container.decodeNil(forKey: key) {
 if value {
 return JSONNull()
 }
 }
 if var container = try? container.nestedUnkeyedContainer(forKey: key) {
 return try decodeArray(from: &container)
 }
 if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
 return try decodeDictionary(from: &container)
 }
 throw decodingError(forCodingPath: container.codingPath)
 }

 static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
 var arr: [Any] = []
 while !container.isAtEnd {
 let value = try decode(from: &container)
 arr.append(value)
 }
 return arr
 }

 static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
 var dict = [String: Any]()
 for key in container.allKeys {
 let value = try decode(from: &container, forKey: key)
 dict[key.stringValue] = value
 }
 return dict
 }

 static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
 for value in array {
 if let value = value as? Bool {
 try container.encode(value)
 } else if let value = value as? Int64 {
 try container.encode(value)
 } else if let value = value as? Double {
 try container.encode(value)
 } else if let value = value as? String {
 try container.encode(value)
 } else if value is JSONNull {
 try container.encodeNil()
 } else if let value = value as? [Any] {
 var container = container.nestedUnkeyedContainer()
 try encode(to: &container, array: value)
 } else if let value = value as? [String: Any] {
 var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
 try encode(to: &container, dictionary: value)
 } else {
 throw encodingError(forValue: value, codingPath: container.codingPath)
 }
 }
 }

 static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
 for (key, value) in dictionary {
 let key = JSONCodingKey(stringValue: key)!
 if let value = value as? Bool {
 try container.encode(value, forKey: key)
 } else if let value = value as? Int64 {
 try container.encode(value, forKey: key)
 } else if let value = value as? Double {
 try container.encode(value, forKey: key)
 } else if let value = value as? String {
 try container.encode(value, forKey: key)
 } else if value is JSONNull {
 try container.encodeNil(forKey: key)
 } else if let value = value as? [Any] {
 var container = container.nestedUnkeyedContainer(forKey: key)
 try encode(to: &container, array: value)
 } else if let value = value as? [String: Any] {
 var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
 try encode(to: &container, dictionary: value)
 } else {
 throw encodingError(forValue: value, codingPath: container.codingPath)
 }
 }
 }

 static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
 if let value = value as? Bool {
 try container.encode(value)
 } else if let value = value as? Int64 {
 try container.encode(value)
 } else if let value = value as? Double {
 try container.encode(value)
 } else if let value = value as? String {
 try container.encode(value)
 } else if value is JSONNull {
 try container.encodeNil()
 } else {
 throw encodingError(forValue: value, codingPath: container.codingPath)
 }
 }

 public required init(from decoder: Decoder) throws {
 if var arrayContainer = try? decoder.unkeyedContainer() {
 self.value = try JSONAny.decodeArray(from: &arrayContainer)
 } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
 self.value = try JSONAny.decodeDictionary(from: &container)
 } else {
 let container = try decoder.singleValueContainer()
 self.value = try JSONAny.decode(from: container)
 }
 }

 public func encode(to encoder: Encoder) throws {
 if let arr = self.value as? [Any] {
 var container = encoder.unkeyedContainer()
 try JSONAny.encode(to: &container, array: arr)
 } else if let dict = self.value as? [String: Any] {
 var container = encoder.container(keyedBy: JSONCodingKey.self)
 try JSONAny.encode(to: &container, dictionary: dict)
 } else {
 var container = encoder.singleValueContainer()
 try JSONAny.encode(to: &container, value: self.value)
 }
 }
 }

 extension Dictionary {
 func percentEncoded() -> Data? {
 return map { key, value in
 let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
 let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
 return escapedKey + "=" + escapedValue
 }
 .joined(separator: "&")
 .data(using: .utf8)
 }
 }

 extension CharacterSet {
 static let urlQueryValueAllowed: CharacterSet = {
 let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
 let subDelimitersToEncode = "!$&'()*+,;="

 var allowed = CharacterSet.urlQueryAllowed
 allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
 return allowed
 }()
 }

*/
