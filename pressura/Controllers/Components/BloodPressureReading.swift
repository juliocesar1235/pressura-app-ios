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
    @objc private var created_at: String

    init(pulse: Int, systolic: Int, diastolic: Int, id: Int? = -1, created_at: String? = "") {
        
        self.systolic = systolic
        self.diastolic = diastolic
        self.pulse = pulse
//        self.pacient = 0
        if let creationDate = created_at{
            self.created_at = creationDate
        }else{
            self.created_at = "No date"
        }
        if let identifier = id {
            self.id = identifier
        }else {
            self.id = -1
        }
    }

    func getSystolicReading()->Int {return self.systolic}
    func getDiastolicReading()->Int {return self.diastolic}
    func getPulse()->Int {return self.pulse}
    func getCreationDate()->String {return self.created_at}
//    func getPatientId()->Int {return self.pacient}
//    func getId()-> Int {return self.id}

}
