//
//  SceneDelegate.swift
//  Diffable-Datasource-ReactorKit-Example
//
//  Created by SwiftMan on 2022/10/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)

    let mainReactor = MainViewReactor()
    let mainViewController = MainViewController()
    mainViewController.reactor = mainReactor
    window?.rootViewController = UINavigationController(rootViewController: mainViewController)
    window?.makeKeyAndVisible()
  }
}
