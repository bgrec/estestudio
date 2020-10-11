import SwiftUI

/*
 struct ActivityIndicator: UIViewRepresentable {
 @Binding var shouldAnimate: Bool

 func makeUIView(context: Context) -> UIActivityIndicatorView {
 return UIActivityIndicatorView()
 }

 func updateUIView(_ uiView: UIActivityIndicatorView,
 context: Context) {
 if self.shouldAnimate {
 uiView.startAnimating()
 } else {
 uiView.stopAnimating()
 }
 }
 }
 */

struct ActivityIndicator: View {
    @Binding var shouldAnimate: Bool

    var body: some View {
        //#if IOS
        if self.shouldAnimate {
            ProgressView()
        }
        //#else
       //     Text("")
       // #endif
    }
}


