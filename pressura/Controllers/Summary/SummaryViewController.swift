//
//  SummaryViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit
import GoogleSignIn

class SummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let user = GIDSignIn.sharedInstance()?.currentUser {
            navigationItem.title = "¡Hola \(user.profile.givenName!)!"
        } else {
            navigationItem.title = "¡Hola!"
        }
    }

}
