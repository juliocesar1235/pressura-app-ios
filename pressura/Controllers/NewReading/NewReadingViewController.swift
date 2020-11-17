//
//  NewReadingViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class NewReadingViewController: UIViewController {
    
    @IBOutlet weak var btnBloodPressure: UIButton!
    @IBOutlet weak var btnHealthM: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Medición Nueva"
        navigationController?.navigationBar.prefersLargeTitles = true
        btnBloodPressure.layer.cornerRadius = 15
        btnHealthM.layer.cornerRadius = 15
    }

    @IBAction func newBloodPreassure(_ sender: UIButton) {
        let vc = NewBloodPressureReading()
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
