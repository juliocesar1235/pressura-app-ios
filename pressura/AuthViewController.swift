//
//  AuthViewController.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 14/10/20.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTf: UITextField!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Autentificate"
        
        //Analytics events
        Analytics.logEvent("Initial screen", parameters: ["message":"Firebase integration complete"])
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if let email = emailTf.text, let password = passwordTf.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil{
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Ha habido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        if let email = emailTf.text, let password = passwordTf.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil{
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .basic), animated: true)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Ha habido un error al registrar el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
