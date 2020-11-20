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
        inputWeight.setInitValues(instruction: "Peso (kg)", placehoder: "70", width: inputWeight.frame.width)
        inputAbdominalGirth.setInitValues(instruction: "Circumferencia abdominal (cm)", placehoder: "100", width: inputAbdominalGirth.frame.width)
        inputDrugsAttachment.setInitValues(instruction: "Apego al medicamento", width: inputDrugsAttachment.frame.width)
        inputDietAttachment.setInitValues(instruction: "Apego a la dieta", width: inputDietAttachment.frame.width)
        inputExerciseAttachment.setInitValues(instruction: "Apego a rutina de ejercicio", width: inputExerciseAttachment.frame.width)
        inputAdditionalComment.setInitValues(instruction: "¿Cómo me he sentido?",placehoder: "Comentario Breve", width: inputAdditionalComment.frame.width)
        
        inputWeight.textFieldInput.keyboardType = .decimalPad
        inputAbdominalGirth.textFieldInput.keyboardType = .decimalPad
    }
    
    @IBAction func addNewHealthReading(_ sender: Any) {
        let newHealthReading = GeneralHealthReading(
            weight:  Double(inputWeight.getInputText()!)!,
            abdominal_circumference: Double(inputAbdominalGirth.getInputText()!)!,
            treatment_compliance: inputDrugsAttachment.getScaleValue(),
            diet_compliance: inputDietAttachment.getScaleValue(),
            exercise_compliance: inputExerciseAttachment.getScaleValue(),
            comment: inputAdditionalComment.getInputText()!
        )
        
        APIManager.shared.postGeneralHealthReadings(newHealthReading: newHealthReading) { (reading, message) in
            if let msg = message {
                // TODO: hacer un alert que hubo error al hacer el post
                print("Alert")
            }else {
                if let tabBarController = self.view.window!.rootViewController as? MainTabBarController {
                    let tabBar = self.tabBarController
                    let nvc = tabBar!.viewControllers![0] as? UINavigationController
                    let vc: SummaryViewController = nvc?.viewControllers[0] as! SummaryViewController
                    
                    vc.generalHealthReadings.append(reading!)
                    vc.reloadDataOfHealthReadings()
                    
                    tabBarController.selectedIndex = 0
                }
            }
        }
    }
}
