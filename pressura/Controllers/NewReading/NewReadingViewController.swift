//
//  NewReadingViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class NewReadingViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Medición Nueva"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func newBloodPreassure(_ sender: UIButton) {
        let vc = NewBloodPreassureReading()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = false
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func newHealdthM(_ sender: UIButton) {
        let vc = NewHealthTrackingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
