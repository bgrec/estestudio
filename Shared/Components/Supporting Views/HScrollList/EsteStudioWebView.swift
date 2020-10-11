import SwiftUI

struct EsteStudioWebView: View {

    @Environment(\.colorScheme) var colorScheme
    @State private var showingEstestudioWeb = false

    var body: some View {

        Button(action: {
            self.showingEstestudioWeb.toggle()
        }) {
            Image(colorScheme == .dark ? "logo_dark" : "logo_light")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: self.$showingEstestudioWeb) {
            SafariView(url: estestudioUrl)
        }
    }
}

// MARK: - Preview
struct EsteStudioWebView_Previews: PreviewProvider {
    static var previews: some View {
        EsteStudioWebView()
    }
}

