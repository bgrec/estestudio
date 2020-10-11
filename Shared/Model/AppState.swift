import Combine

final class AppState: ObservableObject {
    // private setter because no other object should be able to modify this
    private (set) var previousSelectedTab = -1
    @Published var selectedTab: Int = 0 {
        didSet {
            previousSelectedTab = oldValue
        }
    }
}
