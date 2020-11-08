//
//  User.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//
import Foundation

class User : Codable {
    @objc private var is_doctor : Bool
    @objc private var doctor_id : Int
    @objc private var export_id : Int

    init() {
        self.is_doctor = false
        self.doctor_id = 0
        self.export_id = 0
    }

    func isDoctor()->Bool {return self.is_doctor}
    func getDoctorId()->Int {return self.doctor_id}
    func getExportId()->Int {return self.export_id}

}
