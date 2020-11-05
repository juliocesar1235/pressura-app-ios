//
//  NewBloodPreassureReading.swift
//  pressura
//
//  Created by Raúl Castellanos on 18/10/20.
//

import UIKit

class NewBloodPreassureReading: UIViewController {

    @IBOutlet weak var inputSystolePressure: InputTextFieldUIView!
    @IBOutlet weak var inputDiastolePressure: InputTextFieldUIView!
    @IBOutlet weak var inputPulse: InputTextFieldUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureComponents()
        navigationItem.title = "Presión Arterial"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureComponents(){
        inputSystolePressure.setInitValues(instruction: "Presión sistólica", placehoder: "100", width: inputSystolePressure.frame.width)
        inputDiastolePressure.setInitValues(instruction: "Presión diastólica", placehoder: "90", width: inputDiastolePressure.frame.width)
        inputPulse.setInitValues(instruction: "Pulso", placehoder: "70", width: inputPulse.frame.width)
    }



}
