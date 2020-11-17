//
//  AuthViewController.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 14/10/20.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var inputEmail: InputTextFieldUIView!
    @IBOutlet weak var inputPasword: InputTextFieldUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configComponents()
    }
    
    func configComponents(){
        inputEmail.setInitValues(instruction: "Usuario", placehoder: "Nombre", width: inputEmail.frame.width)
        inputPasword.setInitValues(instruction: "Contraseña", placehoder: "Contraseña", width: inputPasword.frame.width)
        inputPasword.textFieldInput.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let email = inputEmail.getInputText()!
        let pws = inputPasword.getInputText()!
        APIManager.shared.login(email: email, password: pws) { (txt) in
            print(txt!)
        }
        
    }

 
    
}
