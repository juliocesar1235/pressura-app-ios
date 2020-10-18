//
//  SceneDelegate.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 14/10/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupView(windowScene: windowScene)
    }
    
    private func setupView(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainTabBarController() // Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
    }


}
