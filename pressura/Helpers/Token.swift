//
//  Token.swift
//  pressura
//
//  Created by Raúl Castellanos on 07/11/20.
//

import Foundation

class Token: Codable {
    @objc private var token : String
    
    init(){
        self.token = ""
    }
    
    func getToken() -> String { return token }
}
