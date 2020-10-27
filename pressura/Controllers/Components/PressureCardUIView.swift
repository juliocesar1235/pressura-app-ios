//
//  PressureCardUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 25/10/20.
//

import UIKit
// Esta cosa de Designable, es para que se renderice en la vista una vez
//  que se haga build.
//@IBDesignable
// Final bc of increase build performance and desing (supuestamente)
final class PressureCardUIView: UIView {
    
    @IBOutlet private weak var pressionSistolica: UILabel!
    @IBOutlet private weak var presionDiastolica: UILabel!
    @IBOutlet private weak var pulso: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "PressureCardComponent")
        else { return }
        view.layer.cornerRadius = 16
        view.frame = self.bounds
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        self.addSubview(view)
    }
    
    func configureCard(pSistolica: String, pDiastolica: String, pulso: String){
        self.pressionSistolica.text = pSistolica
        self.presionDiastolica.text = pDiastolica
        self.pulso.text = pulso
    }

}
