//
//  GeneralHealthReading.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//
import Foundation

class GeneralHealthReading : Codable {
    @objc private var weight : Double
    @objc private var abdominal_circumference : Int
    @objc private var treatment_compliance : Int
    @objc private var diet_compliance : Int
    @objc private var comment : String
    @objc private var patientId : Int

    init() {
        self.weight = 0.0
        self.abdominal_circumference = 0
        self.treatment_compliance = 0
        self.diet_compliance = 0
        self.comment = ""
        self.patientId = 0
    }

    func getWeight()->Double {return self.weight}
    func getAbdominalCircumference()->Int {return self.abdominal_circumference}
    func getTreatmentComplience()->Int {return self.treatment_compliance}
    func getDietComplience()->Int {return self.diet_compliance}
    func getComment()->String {return self.comment}
    func getPatientId()->Int {return self.patientId}

}
