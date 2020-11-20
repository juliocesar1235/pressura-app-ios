//
//  NewHealthTrackingViewController.swift
//  pressura
//
//  Created by Raúl Castellanos on 18/10/20.
//

import UIKit

class NewHealthTrackingViewController: UIViewController {

    @IBOutlet weak var inputWeight: InputTextFieldUIView!
    @IBOutlet weak var inputDrugsAttachment: InputLickerScaleUIView!
    @IBOutlet weak var inputAbdominalGirth: InputTextFieldUIView!
    @IBOutlet weak var inputDietAttachment: InputLickerScaleUIView!
    @IBOutlet weak var inputExerciseAttachment: InputLickerScaleUIView!
    @IBOutlet weak var inputAdditionalComment: InputTextFieldUIView!
    
    override func viewDidLoad() {
        // Esto es para ajustar el tamaño dependiendo del dispositivo
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        configureComponents()
        navigationItem.title = "Monitoreo"
        navigationItem.backButtonTitle = "Medición Nueva"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureComponents(){
        inputWeight.setInitValues(
            instruction: "Peso (kg)",
            placehoder: "70",
            width: inputWeight.frame.width
        )
        inputAbdominalGirth.setInitValues(
            instruction: "Circumferencia abdominal (cm)",
            placehoder: "100",
            width: inputAbdominalGirth.frame.width
        )
        inputDrugsAttachment.setInitValues(
            instruction: "Apego al medicamento",
            width: inputDrugsAttachment.frame.width
        )
        inputDietAttachment.setInitValues(
            instruction: "Apego a la dieta",
            width: inputDietAttachment.frame.width
        )
        inputExerciseAttachment.setInitValues(
            instruction: "Apego a rutina de ejercicio",
            width: inputExerciseAttachment.frame.width
        )
        inputAdditionalComment.setInitValues(
            instruction: "¿Cómo me he sentido?",
            placehoder: "Comentario Breve",
            width: inputAdditionalComment.frame.width
        )
        inputWeight.textFieldInput.keyboardType = .decimalPad
        inputAbdominalGirth.textFieldInput.keyboardType = .decimalPad
    }
    
    @IBAction func addNewHealthReading(_ sender: Any) {
        
        if let w = inputWeight.getInputText(), let weight = Double(w),
           let a = inputAbdominalGirth.getInputText(), let abdominal_circumference = Double(a),
           let treatment_compliance = inputDrugsAttachment.getScaleValue(),
           let diet_compliance = inputDietAttachment.getScaleValue(),
           let exercise_compliance = inputExerciseAttachment.getScaleValue(),
           let comment = inputAdditionalComment.getInputText() {
            
            let newHealthReading = GeneralHealthReading(weight: weight, abdominal_circumference: abdominal_circumference, treatment_compliance: treatment_compliance, diet_compliance: diet_compliance, exercise_compliance: exercise_compliance, comment: comment)
        
            APIManager.shared.postGeneralHealthReadings(newHealthReading: newHealthReading) { (reading, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    if let tabBarController = self.view.window!.rootViewController as? MainTabBarController {
                        self.resetInputFields()
                        let tabBar = self.tabBarController
                        let nvc = tabBar!.viewControllers![0] as? UINavigationController
                        let vc: SummaryViewController = nvc?.viewControllers[0] as! SummaryViewController
                        vc.generalHealthReadings.append(reading!)
                        vc.reloadDataOfHealthReadings()
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
        inputWeight.textFieldInput.text = ""
        inputAbdominalGirth.textFieldInput.text = ""
        inputAdditionalComment.textFieldInput.text = ""
        self.navigationController?.popViewController(animated: true)
    }
}
