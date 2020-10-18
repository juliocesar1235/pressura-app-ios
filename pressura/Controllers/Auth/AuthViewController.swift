//
//  AuthViewController.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 14/10/20.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import GoogleSignIn

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Analytics events
        Analytics.logEvent("Initial screen", parameters: ["message":"Firebase integration complete"])
        
        // Signin with Google
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(goToHome),
                                               name: .signInGoogleCompleted,
                                               object: nil)
                
    }
    
    
    @objc func goToHome() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController())
    }
    
}
