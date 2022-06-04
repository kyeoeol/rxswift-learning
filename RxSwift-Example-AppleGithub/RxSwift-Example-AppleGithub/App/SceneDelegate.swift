//
//  SceneDelegate.swift
//  RxSwift-Example-AppleGithub
//
//  Created by kyeoeol on 2022/06/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = MainListViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

