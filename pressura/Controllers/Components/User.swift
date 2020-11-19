//
//  User.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//
import Foundation

class User : Codable {
    
    @objc var username: String?
    @objc var first_name: String?
    @objc var last_name: String?
    @objc var email: String?

    init() {
        self.username = ""
        self.first_name = ""
        self.last_name = ""
        self.email = ""
    }
}
