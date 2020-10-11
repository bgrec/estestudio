import Foundation
import SwiftUI

struct SheetPresenter<Content>: View where Content: View {

    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var appState: AppState
    @Binding var isPresenting: Bool
    //@Binding var showOtherTab: Int

    var content: Content

    var body: some View {
        HStack {
            Image(systemName: "calendar.badge.plus")
            Text("Nuovo appuntamento")
        }
        .padding()
        .overlay( RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
        .sheet(isPresented: self.$isPresenting, onDismiss: {
            self.appState.selectedTab = self.appState.previousSelectedTab
            self.appointmentsViewModel.load(old: false)
        }, content: { self.content })
    }
}

