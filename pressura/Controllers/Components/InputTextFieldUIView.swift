//
//  InputComponentUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 26/10/20.
//

import UIKit

final class InputTextFieldUIView: UIView {
    
    @IBOutlet var InputComponentView: UIView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var infoBtn: UIButton!
    
    
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
    
    func setInitValues(instruction: String, placehoder: String, width: CGFloat, hasInfoBtn: Bool = true){
        lblInstruction.text = instruction
        textFieldInput.placeholder = placehoder
        InputComponentView.frame.size.width = width
        infoBtn.isHidden = !hasInfoBtn
    }
    
    // Tal vez en este caso seria más conveniente que lblInstruction
    // y textFieldInput no fueran privados

}
