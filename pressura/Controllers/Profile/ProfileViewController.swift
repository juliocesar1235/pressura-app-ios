//
//  ProfileViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var inputNameComponent: InputTextFieldUIView!
    @IBOutlet weak var inputMailComponent: InputTextFieldUIView!
    
    let userDefaults : UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationItem.title = "Mi información"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureComponents()
    }
    
    func configureComponents(){
        do {
            let user = try userDefaults.getObject(forKey: "user", castTo: User.self)
            inputNameComponent.textFieldInput.text = "\(user.first_name ?? "") \(user.last_name ?? "")"
            inputMailComponent.textFieldInput.text = user.email ?? ""
        } catch {
            
        }
        
        inputNameComponent.setInitValues(
            instruction: "Nombre",
            placehoder: "Mi nombre",
            width: inputNameComponent.frame.width
        )
        inputMailComponent.setInitValues(
            instruction: "Correo electrónico",
            placehoder: "user@pressura.com",
            width: inputMailComponent.frame.width
        )

        inputNameComponent.textFieldInput.isEnabled = false
        inputMailComponent.textFieldInput.isEnabled = false
        inputMailComponent.textFieldInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        inputNameComponent.textFieldInput.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "user")
        goToLogin()
    }
    
    @objc func goToLogin() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(AuthViewController())
    }
}
