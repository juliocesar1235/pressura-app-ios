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
    @objc private var exercise_compliance : Int
    @objc private var comment : String
    @objc private var patientId : Int

    init(weight: Double, abdominal_circumference: Int, treatment_compliance: Int, diet_compliance: Int, exercise_compliance: Int, comment: String, id: Int? = -1) {
        self.weight = weight
        self.abdominal_circumference = abdominal_circumference
        self.treatment_compliance = treatment_compliance
        self.diet_compliance = diet_compliance
        self.exercise_compliance = exercise_compliance
        self.comment = comment
        if let identifier = id {
            self.patientId = identifier
        }else {
            self.patientId = -1
        }
    }

    func getWeight()->Double {return self.weight}
    func getAbdominalCircumference()->Int {return self.abdominal_circumference}
    func getTreatmentComplience()->Int {return self.treatment_compliance}
    func getDietComplience()->Int {return self.diet_compliance}
    func getExerciseCompliance()->Int {return self.exercise_compliance}
    func getComment()->String {return self.comment}
    func getPatientId()->Int {return self.patientId}

}
