//
//  SignupViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 16/11/20.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var inputEmail: InputTextFieldUIView!
    @IBOutlet weak var inputUsername: InputTextFieldUIView!
    @IBOutlet weak var inputFirstName: InputTextFieldUIView!
    @IBOutlet weak var inputLastName: InputTextFieldUIView!
    @IBOutlet weak var inputPasword: InputTextFieldUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configComponents()
        self.hideKeyboardWhenTappedAround()
    }
    
    func configComponents(){
        inputEmail.setInitValues(
            instruction: "Correo electrónico",
            placehoder: "correo@pressura.com",
            width: inputEmail.frame.width
        )
        inputUsername.setInitValues(
            instruction: "Nombre de usuario",
            placehoder: "Usuario",
            width: inputEmail.frame.width
        )
        inputFirstName.setInitValues(
            instruction: "Nombre",
            placehoder: "Jesús",
            width: inputFirstName.frame.width
        )
        inputLastName.setInitValues(
            instruction: "Apellido",
            placehoder: "Pérez",
            width: inputLastName.frame.width
        )
        inputPasword.setInitValues(
            instruction: "Contraseña",
            placehoder: "Contraseña",
            width: inputPasword.frame.width
        )
        inputPasword.textFieldInput.isSecureTextEntry = true
    }

    @IBAction func signUp(_ sender: UIButton) {
        if let username = inputUsername.getInputText(), !username.isEmpty,
           let firstName = inputFirstName.getInputText(), !firstName.isEmpty,
           let lastName = inputLastName.getInputText(), !lastName.isEmpty,
           let email = inputEmail.getInputText(), !email.isEmpty,
           let password = inputPasword.getInputText(), !password.isEmpty {
            
            APIManager.shared.signUp(username: username, firstName: firstName, lastName: lastName, email: email, password: password) { (token, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    APIManager.shared.login(username: username, password: password) {
                        (token, error) in
                        if let _ = token {
                            APIManager.shared.getUser() { (user, _) in
                                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController())
                            }
                        }
                    }
                }
            }
        } else {
            let alert = UIAlertController(
                title: "Error",
                message: "Por favor llena todos los campos correctamente.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
}
