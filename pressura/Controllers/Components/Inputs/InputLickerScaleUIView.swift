//
//  InputLickerScaleUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 01/11/20.
//

import UIKit

final class InputLickerScaleUIView: UIView  {
    
    @IBOutlet var InputLickerComponentView: UIView!
    @IBOutlet private weak var lblInstruction: UILabel!
    @IBOutlet private weak var radioContainer1: UIView!
    @IBOutlet private weak var radioContainer2: UIView!
    @IBOutlet private weak var radioContainer3: UIView!
    @IBOutlet private weak var radioContainer4: UIView!
    
    private var radiosArray: [LTHRadioButton] = []
    private var viewsRadiosArray: [UIView] = []
    private var selectedButton: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureView()
    }
    
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "InputLickerScaleComponent")
            else { return }
        self.addSubview(view)
        self.createRadioButtons()
        self.addContainers()
        self.addRadiosToViews()
    }
    
    private func createRadioButtons(){
        // This should be with pointers, later
        let radioBtn1 = LTHRadioButton(diameter: 23)
        radioBtn1.select() // It's the default one
        let radioBtn2 = LTHRadioButton(diameter: 23)
        let radioBtn3 = LTHRadioButton(diameter: 23)
        let radioBtn4 = LTHRadioButton(diameter: 23)
        radiosArray.append(radioBtn1)
        radiosArray.append(radioBtn2)
        radiosArray.append(radioBtn3)
        radiosArray.append(radioBtn4)
    }
    
    private func addContainers(){
        viewsRadiosArray.append(radioContainer1)
        viewsRadiosArray.append(radioContainer2)
        viewsRadiosArray.append(radioContainer3)
        viewsRadiosArray.append(radioContainer4)
    }
    
    private func addRadiosToViews(){
        for id in 0...3 {
            viewsRadiosArray[id].addSubview(radiosArray[id])
            radiosArray[id].translatesAutoresizingMaskIntoConstraints = true
            NSLayoutConstraint.activate([
                radiosArray[id].centerYAnchor.constraint(equalTo: viewsRadiosArray[id].centerYAnchor),
                radiosArray[id].centerXAnchor.constraint(equalTo: viewsRadiosArray[id].centerXAnchor)
            ])
            radiosArray[id].onSelect {
                self.setRadiosFalse(selected: id)
            }
        }
        
    }
        
    private func setRadiosFalse(selected: Int) {
        radiosArray[selectedButton].deselect()
        selectedButton = selected
    }
    
    func setInitValues(instruction: String, width: CGFloat){
        lblInstruction.text = instruction
        InputLickerComponentView.frame.size.width = width
    }
    func getScaleValue() -> Int?{
        return selectedButton as? Int
    }
   
    
    
}
