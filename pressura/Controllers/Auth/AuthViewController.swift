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
        inputEmail.setInitValues(instruction: "Correo", placehoder: "email@pressura.com", width: inputEmail.frame.width)
        inputPasword.setInitValues(instruction: "Contraseña", placehoder: "123", width: inputPasword.frame.width)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let email = inputEmail.getInputText()!
        let pws = inputPasword.getInputText()!
        APIManager.shared.login(email: email, password: pws) { (txt) in
            print(txt!)
        }
        
    }

    @objc func goToHome() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController())
    }
    
}
