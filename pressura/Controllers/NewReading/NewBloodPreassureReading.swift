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
        let newPressure = BloodPressureReading(
            pulse: Int(inputPulse.getInputText()!)!,
            systolic: Int(inputSystolePressure.getInputText()!)!,
            diastolic: Int(inputDiastolePressure.getInputText()!)!
        )
        
        APIManager.shared.postBloodReadings(newPressure: newPressure) { (reading, message) in
            if let msg = message {
                // TODO: hacer un alert
                print("Alert")
            }else {
                if let tabBarController = self.view.window!.rootViewController as? MainTabBarController {
                    let tabBar = self.tabBarController
                    let nvc = tabBar!.viewControllers![0] as? UINavigationController
                    let vc: SummaryViewController = nvc?.viewControllers[0] as! SummaryViewController
                    
                    vc.bloodReadings.append(reading!)
                    vc.reloadDataOfBloodPressure()
                    tabBarController.selectedIndex = 0
                }
            }
        }
    }
}
