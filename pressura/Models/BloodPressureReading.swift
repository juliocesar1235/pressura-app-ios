//
//  BloodPressureReading.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//

import Foundation

class BloodPressureReading : Codable {
    @objc private var systolic : Int
    @objc private var diastolic : Int
    @objc private var pulse : Int
    @objc private var patientId : Int
    
    init() {
        self.systolic = 0
        self.diastolic = 0
        self.pulse = 0
        self.patientId = 0
    }
    
    func getSystolicReading()->Int {return self.systolic}
    func getDiastolicReading()->Int {return self.diastolic}
    func getPulse()->Int {return self.pulse}
    func getPatientId()->Int {return self.patientId}
    
}
