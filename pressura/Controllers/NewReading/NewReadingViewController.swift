//
//  NewReadingViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit

class NewReadingViewController: UIViewController {
    
    @IBOutlet weak var bloodPressure: UIView!
    @IBOutlet weak var healthReadings: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        bloodPressure.backgroundColor = .white
        healthReadings.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Medición Nueva"
        navigationController?.navigationBar.prefersLargeTitles = true
        let gestureBloodP = UITapGestureRecognizer(target: self, action: #selector(newBloodPreassure))
        let gestureHealthR = UITapGestureRecognizer(target: self, action: #selector(newHealdthM))
        self.bloodPressure.addGestureRecognizer(gestureBloodP)
        self.healthReadings.addGestureRecognizer(gestureHealthR)
    }

    @objc func newBloodPreassure(_ sender: UIButton) {
        bloodPressure.backgroundColor = #colorLiteral(red: 0.902751565, green: 0.8979362249, blue: 0.9064626694, alpha: 1)
        let vc = NewBloodPressureReading()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func newHealdthM(_ sender: UIButton) {
        healthReadings.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8980392157, blue: 0.9058823529, alpha: 1)
        let vc = NewHealthTrackingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.hidesBackButton = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
