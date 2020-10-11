import Foundation
import SwiftUI
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView
    
    init(_ control: MapView) {
        self.mapViewController = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
            
        } else {
            annotationView!.annotation = annotation
        }
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
        
        let pinImage = UIImage(systemName: "mappin.circle.fill", withConfiguration: config)
        pinImage?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        
        annotationView!.image = pinImage
        annotationView!.calloutOffset = CGPoint(x: -5, y: 5)

        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
        
        mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
        annotationView!.rightCalloutAccessoryView = mapsButton
        return annotationView
    }
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: estestudioCoordinates, addressDictionary: nil))
        mapItem.name = "èSTEstudio"
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}

struct MapViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: estestudioCoordinates)
    }
}
