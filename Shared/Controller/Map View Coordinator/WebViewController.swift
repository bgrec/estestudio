import Foundation
import SwiftUI
import WebKit

class WebViewController: UIViewController {
    lazy var webView: WKWebView = WKWebView()
    lazy var progressBar: UIProgressView = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.frame = self.view.frame
        self.view.addSubview(self.webView)
        
        self.view.addSubview(self.progressBar)
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.progressBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.progressBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.progressBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.progressBar.progress = 0.1
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    // MARK: - Web view progress
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressBar.alpha = 0.0
                }, completion: { _ in
                    self.progressBar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressBar.isHidden = false
                self.progressBar.alpha = 1.0
                progressBar.setProgress(Float(self.webView.estimatedProgress), animated: true)
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

struct WebViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
