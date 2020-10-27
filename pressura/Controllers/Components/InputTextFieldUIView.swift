//
//  InputComponentUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 26/10/20.
//

import UIKit

final class InputTextFieldUIView: UIView {
    
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var textFieldInput: UITextField!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureView()
    }
    
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "InputTextFieldComponent")
            else { return }
        self.addSubview(view)
    }
    
    func setInputInstruction(instruction: String){
        lblInstruction.text = instruction
    }
    // Tal vez en este caso seria más conveniente que lblInstruction
    // y textFieldInput no fueran privados

}
