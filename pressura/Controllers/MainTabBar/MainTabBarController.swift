//
//  MainTabBarController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeController = createNavigationController(
            vc: SummaryViewController(),
            image: UIImage(systemName: "house")!,
            title: "Resumen",
            tag: 0
        )
        
        let newReadingController = createNavigationController(
            vc: NewReadingViewController(),
            image: UIImage(systemName: "plus")!,
            title: "Nueva medición",
            tag: 1
        )
        
        let profileController = createNavigationController(
            vc: ProfileViewController(),
            image: UIImage(systemName: "person.crop.circle")!,
            title: "Perfil",
            tag: 2
        )
        
        viewControllers = [homeController, newReadingController, profileController]
    }

}

extension UITabBarController {
    
    func createNavigationController(vc: UIViewController, image:UIImage, title: String, tag: Int) -> UINavigationController {
        let viewController = vc
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        return navigationController
    }
}
