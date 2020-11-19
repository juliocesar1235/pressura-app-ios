//
//  GeneralHealthReading.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//
import Foundation

class GeneralHealthReading : Codable {
    @objc private var weight : String
    @objc private var abdominal_circumference : String
    @objc private var treatment_compliance : Int
    @objc private var exercise_compliance : Int
    @objc private var diet_compliance : Int
    @objc private var comment : String
    @objc private var id: Int
//    @objc private var patient : Int

    init(weight: Double, abdominal_circumference: Double, treatment_compliance: Int, diet_compliance: Int, exercise_compliance: Int, comment: String, id: Int? = -1) {
        self.weight = String(weight)
        self.abdominal_circumference = String(abdominal_circumference)
        self.treatment_compliance = treatment_compliance
        self.diet_compliance = diet_compliance
        self.exercise_compliance = exercise_compliance
        self.comment = comment
        if let identifier = id {
            self.id = identifier
        }else {
            self.id = -1
        }
    }

    func getWeight()->String {return self.weight}
    func getAbdominalCircumference()->String {return self.abdominal_circumference}
    func getTreatmentComplience()->Int {return self.treatment_compliance}
    func getDietComplience()->Int {return self.diet_compliance}
    func getExerciseCompliance()->Int {return self.exercise_compliance}
    func getComment()->String {return self.comment}
    func getPatientId()->Int {return self.id}

}
