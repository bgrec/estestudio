import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> WebViewController {
        let webViewController = WebViewController()
        
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webViewController.webView.load(request)
        
        return webViewController
    }
    
    func updateUIViewController(_ webViewController: WebViewController, context: Context) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webViewController.webView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: newAppointmentUrl)
    }
}
