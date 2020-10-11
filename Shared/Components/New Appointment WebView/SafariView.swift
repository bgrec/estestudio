import Foundation
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SafariViewController
    
    var url: URL?
    
    func makeUIViewController(context: Context) -> SafariViewController {
        return SafariViewController()
    }
    
    func updateUIViewController(_ safariViewController: SafariViewController, context: Context) {
        safariViewController.url = url
    }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: newAppointmentUrl)}
}
