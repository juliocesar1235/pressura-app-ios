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
        APIManager.shared.signUp(
            username: inputUsername.getInputText()!,
            firstName: inputFirstName.getInputText()!,
            lastName: inputLastName.getInputText()!,
            email: inputEmail.getInputText()!,
            password: inputPasword.getInputText()!
        ) { (_, _) in
            APIManager.shared.login(username: self.inputUsername.getInputText()!, password: self.inputPasword.getInputText()!) { (txt) in
                print(txt!)
            }
        }
    }
}
