//
//  ProfileViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var inputNameComponent: InputTextFieldUIView!
    @IBOutlet weak var inputMailComponent: InputTextFieldUIView!
    @IBOutlet weak var inputMyDoctor: InputTextFieldUIView!
    
    let userDefaults : UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mi información"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureComponents()
    }
    
    func configureComponents(){
        inputNameComponent.setInitValues(instruction: "Nombre", placehoder: "Mi nombre", width: inputNameComponent.frame.width)
        inputMailComponent.setInitValues(instruction: "Correo electrónico", placehoder: "user@pressura.com", width: inputMailComponent.frame.width)
        inputMyDoctor.setInitValues(instruction: "Mi médico", placehoder: "891-555-66-44", width: inputMyDoctor.frame.width)
        inputNameComponent.textFieldInput.isEnabled = false
        inputMailComponent.textFieldInput.isEnabled = false
        inputMailComponent.textFieldInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        inputNameComponent.textFieldInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
//        if let user = GIDSignIn.sharedInstance()?.currentUser {
//            inputNameComponent.textFieldInput.text = "\(user.profile.givenName!) \(user.profile.familyName!)"
//            inputMailComponent.textFieldInput.text = "\(user.profile.email!)"
//        }
        
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        userDefaults.removeObject(forKey: "token")
        print(userDefaults.string(forKey: "token"))
        goToLogin()
    }
    
    @objc func goToLogin() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AuthViewController())
    }
}
