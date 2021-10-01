//
//  SceneDelegate.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 27/09/2021.
//

import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    @Injected var userRepository: UserRepository
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navVC: UINavigationController
        if userRepository.isLoggedIn() {
            let vc = CustomersListTableViewController(nib: R.nib.customersListTableView)
            navVC = UINavigationController(rootViewController: vc)
        } else {
            let vc = PhoneEntryViewController(nib: R.nib.phoneEntryView)
            navVC = UINavigationController(rootViewController: vc)
        }
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

