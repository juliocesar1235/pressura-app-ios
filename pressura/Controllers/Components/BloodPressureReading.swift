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
    @objc private var id: Int

    init(pulse: Int, systolic: Int, diastolic: Int, id: Int? = -1) {
        
        self.systolic = systolic
        self.diastolic = diastolic
        self.pulse = pulse
        if let identifier = id {
            self.id = identifier
        }else {
            self.id = -1
        }
    }

    func getSystolicReading()->Int {return self.systolic}
    func getDiastolicReading()->Int {return self.diastolic}
    func getPulse()->Int {return self.pulse}
}
