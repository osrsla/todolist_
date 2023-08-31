import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    let homeVC = HomeViewController()

    let taskVC = TaskViewController()
    let detailVC = DetailViewController()
    let editVC = EditViewController()
    let createVC = CreateViewController()

    let catVC = CatViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let navigationController = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navigationController

        return true
    }
}
