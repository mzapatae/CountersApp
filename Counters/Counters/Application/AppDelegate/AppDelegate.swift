//
//  AppDelegate.swift
//  Counters
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        return true
    }
}

