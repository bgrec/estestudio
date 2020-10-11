import Foundation
import StoreKit

enum AppStoreReviewManager {

    static let minimumTimesLaunched = 3

    //1
    static func isFirstLaunch() -> Bool {
        let actionCount = defaults.integer(forKey: "timesLaunched")
        guard actionCount == 0  else {
            return false
        }
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
        defaults.set(currentVersion, forKey: "savedVersion")
        return true
    }
    //2
    static func isNewVersion() -> Bool {
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = defaults.string(forKey: "savedVersion")

        guard lastVersion != currentVersion
            && currentVersion != "1" else {
                return false
        }
        return true
    }
    //3 last to use
    static func requestReviewIfAppropiate() {

        var  actionCount = defaults.integer(forKey: "timesLaunched")
        actionCount += 1
        defaults.set(actionCount, forKey: "timesLaunched")
        guard actionCount >= minimumTimesLaunched else {
            return
        }

        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = defaults.string(forKey: "savedVersion")
        guard lastVersion == nil || lastVersion != currentVersion else {
            return
        }

        SKStoreReviewController.requestReview()

        defaults.set(1, forKey: "timesLaunched")
        defaults.set(currentVersion, forKey: "savedVersion")
    }

}

// TO - DO later 
import UIKit

final class SettingsViewController: UITableViewController {
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            writeReview()
        } else if indexPath.row == 1 {
            share()
        }
    }

    // MARK: - Actions

    private let productURL = URL(string: "https://itunes.apple.com/app/id958625272")!

    private func writeReview() {
        var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "action", value: "write-review")
        ]
        
        guard let writeReviewURL = components?.url else {
            return
        }

        UIApplication.shared.open(writeReviewURL)
    }

    private func share() {
        let activityViewController = UIActivityViewController(activityItems: [productURL],
                                                              applicationActivities: nil)

        present(activityViewController, animated: true, completion: nil)
    }
}
