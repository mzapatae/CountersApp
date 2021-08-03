import UIKit
import CounterList
import AltairMDKCommon

protocol StartFlow {
    func coordinateToCounterListScene()
}

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let presenter = WelcomeViewPresenter()
        presenter.coordinator = self
        let welcomeViewController = WelcomeViewController(presenter: presenter)
        navigationController.pushViewController(welcomeViewController, animated: true)
    }
    
}

extension AppCoordinator: StartFlow {
    
    func coordinateToCounterListScene() {
        let counterListCoordinator = CounterListCoordinator(navigationController: navigationController)
        coordinate(to: counterListCoordinator)
    }
    
}