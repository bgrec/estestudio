import Foundation
import SwiftUI
import MapKit

struct MapViewAdvanced: UIViewRepresentable {
    
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        let esteStudio = MKPointAnnotation()
        esteStudio.title = "eSTEstudio"
        esteStudio.subtitle = "centro estetico"
        esteStudio.coordinate = coordinate
        mapView.addAnnotation(esteStudio)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapViewAdvanced_Previews: PreviewProvider {
    static var previews: some View {
        MapViewAdvanced(coordinate: estestudioCoordinates)
    }
}
