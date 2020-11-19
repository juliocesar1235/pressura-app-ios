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
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    func configureComponents(){
        inputWeight.setInitValues(instruction: "Peso (kg)", placehoder: "70", width: inputWeight.frame.width)
        inputAbdominalGirth.setInitValues(instruction: "Circumferencia abdominal (cm)", placehoder: "100", width: inputAbdominalGirth.frame.width)
        inputDrugsAttachment.setInitValues(instruction: "Apego al medicamento", width: inputDrugsAttachment.frame.width)
        inputDietAttachment.setInitValues(instruction: "Apego a la dieta", width: inputDietAttachment.frame.width)
        inputExerciseAttachment.setInitValues(instruction: "Apego a rutina de ejercicio", width: inputExerciseAttachment.frame.width)
        inputAdditionalComment.setInitValues(instruction: "¿Cómo me he sentido?",placehoder: "Comentario Breve", width: inputAdditionalComment.frame.width)
    }
    

}
