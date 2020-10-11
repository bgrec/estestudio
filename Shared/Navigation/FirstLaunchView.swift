import SwiftUI

struct FirstLaunchView: View {

    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var userData: UserData

    let message = "Crea il tuo profilo con gli stessi dati che hai utilizzato " +
        "per prenotare l'appuntamento sul sito, in modo che sia piu facile gestirli " +
        "poi dall'applicazione."

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .accessibility(label: Text("Account"))
                        .padding()
                }
                .padding()

                HStack {
                    Text("èSTE studio")
                        .font(.title)
                        .bold()
                }

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
                    .overlay( RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                    .padding()
                    .buttonStyle(PlainButtonStyle())
                }

                Spacer()
            }

            Image(colorScheme == .dark ? "White_pdf" : "Dark_pdf2")
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

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}

