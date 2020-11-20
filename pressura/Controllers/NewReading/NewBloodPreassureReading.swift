//
//  NewBloodPressureReading.swift
//  pressura
//
//  Created by Raúl Castellanos on 18/10/20.
//

import UIKit

class NewBloodPressureReading: UIViewController {

    @IBOutlet weak var inputSystolePressure: InputTextFieldUIView!
    @IBOutlet weak var inputDiastolePressure: InputTextFieldUIView!
    @IBOutlet weak var inputPulse: InputTextFieldUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureComponents()
        navigationItem.title = "Presión Arterial"
        navigationItem.backButtonTitle = "Medición Nueva"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureComponents(){
        inputSystolePressure.setInitValues(instruction: "Presión sistólica", placehoder: "100", width: inputSystolePressure.frame.width)
        inputDiastolePressure.setInitValues(instruction: "Presión diastólica", placehoder: "90", width: inputDiastolePressure.frame.width)
        inputPulse.setInitValues(instruction: "Pulso", placehoder: "70", width: inputPulse.frame.width)
        
        inputSystolePressure.textFieldInput.keyboardType = .numberPad
        inputDiastolePressure.textFieldInput.keyboardType = .numberPad
        inputPulse.textFieldInput.keyboardType = .numberPad
    }

    @IBAction func addNewBloodPressure(_ sender: UIButton) {
        
        if let p = inputPulse.getInputText(), let pulse = Int(p),
           let s = inputSystolePressure.getInputText(), let systolic = Int(s),
           let d = inputDiastolePressure.getInputText(), let diastolic = Int(d) {
            
            let newPressure = BloodPressureReading(pulse: pulse, systolic: systolic, diastolic: diastolic)
            
            APIManager.shared.postBloodReadings(newPressure: newPressure) { (reading, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else {
                    if let tabBarController = self.view.window!.rootViewController as? MainTabBarController {
                        self.resetInputFields()
                        let tabBar = self.tabBarController
                        
                        let nvc = tabBar!.viewControllers![0] as? UINavigationController
                        let vc: SummaryViewController = nvc?.viewControllers[0] as! SummaryViewController
                        vc.bloodReadings.append(reading!)
                        vc.reloadDataOfBloodPressure()
                        tabBarController.selectedIndex = 0
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

    func resetInputFields() {
        inputPulse.textFieldInput.text = ""
        inputSystolePressure.textFieldInput.text = ""
        inputDiastolePressure.textFieldInput.text = ""
        self.navigationController?.popViewController(animated: true)
    }
}
