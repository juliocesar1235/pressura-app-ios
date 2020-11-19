//
//  AuthViewController.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 14/10/20.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var inputUsername: InputTextFieldUIView!
    @IBOutlet weak var inputPasword: InputTextFieldUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configComponents()
    }
    
    func configComponents(){
        inputUsername.setInitValues(instruction: "Usuario", placehoder: "Nombre", width: inputUsername.frame.width)
        inputPasword.setInitValues(instruction: "Contraseña", placehoder: "Contraseña", width: inputPasword.frame.width)
        inputPasword.textFieldInput.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let username = inputUsername.getInputText()!
        let pws = inputPasword.getInputText()!
        APIManager.shared.login(username: username, password: pws) { (txt) in
            print(txt!)
        }
    }
    
    @IBAction func btnSingup(_ sender: UIButton) {
        let vc = SignupViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
    
    
}
