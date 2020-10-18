//
//  ProfileViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Mi información"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let user = GIDSignIn.sharedInstance()?.currentUser {
            tfName.text = "\(user.profile.givenName!) \(user.profile.familyName!)"
            tfEmail.text = "\(user.profile.email!)"
        }
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        goToLogin()
    }
    
    @objc func goToLogin() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AuthViewController())
    }
}
