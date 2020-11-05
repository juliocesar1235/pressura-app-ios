//
//  ApiManager.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager(baseURL: URL(string: "http://localhost:8000")!)
    
    let baseURL : URL
    
    private init(baseURL : URL){
        self.baseURL = baseURL
    }
    
    func signUp(name: String, email: String, password: String, completion: @escaping(User?, String?) -> Void) {
        let params = [
            "name": name,
            "email": email,
            "password": password
        ] as Parameters
        
        AF.request(self.baseURL.appendingPathComponent("/signup"), method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(user, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            }else{
                completion(nil, "An error has ocurred try again")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping(User?, String?) -> Void){
        
        let headers : HTTPHeaders = [
            .authorization(username: email, password: password),
            .accept("application/json")
        ]
        
        AF.request(self.baseURL.appendingPathComponent("/login"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(user, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            }else{
                completion(nil, "Connection error")
            }
            
        }
    }
    
    // This function returns an array of blood pressure readings
    func getBloodReadings(completion: @escaping([BloodPressureReading]?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]
        
        AF.request(self.baseURL.appendingPathComponent("/blood-pressure-readings"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    let bloodPressureReadings = try JSONDecoder().decode([BloodPressureReading].self, from: data)
                    completion(bloodPressureReadings,nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            }else{
                completion(nil, "Connection error")
            }
        }
        
    }
    
    
    
    func getGeneralHealthReadings(completion: @escaping([GeneralHealthReading]?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]
        AF.request(self.baseURL.appendingPathComponent("/general-health-readings"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    let generalHealthReadings = try JSONDecoder().decode([GeneralHealthReading].self, from: data)
                    completion(generalHealthReadings,nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            }else{
                completion(nil, "Connection error")
            }
        }
        
    }
}
