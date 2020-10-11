import SwiftUI

struct WhatsNewView: View {

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var userData: UserData

    let message = "Nuova versione..."

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("èSTE studio")
                        .font(.title)
                        .bold()
                }
                .padding()

                HStack {
                    Text(self.message)
                        .font(.headline)
                }
                .padding()

                Spacer()
                Spacer()
                Spacer()

                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Continua")
                            .font(.title)
                            .bold()
                            .padding()
                    }
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                    .padding()
                    .buttonStyle(PlainButtonStyle())
                }

                Spacer()
            }

            Image(colorScheme == .dark ? "White Watermark" : "Dark_pdf2")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .luminanceToAlpha()
        }
        .alert(isPresented: $appointmentsViewModel.showingAlert) {
            Alert(title: Text("Errore"), message: Text(self.appointmentsViewModel.alertText), dismissButton: .default(Text("OK")))
        }
    }

}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
    }
}

