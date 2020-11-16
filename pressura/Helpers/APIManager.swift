//
//  APIManager.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 04/11/20.
//
import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager(baseURL: URL(string: "http://localhost:8000")!)

    let baseURL : URL
    let userDefaults : UserDefaults = UserDefaults.standard
    
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

    func login(email: String, password: String, completion: @escaping(String?) -> Void){
        let headers : HTTPHeaders = [
            .accept("application/json")
        ]
        let parameters : Parameters = [ "username": email, "password": password]
        

        AF.request(self.baseURL.appendingPathComponent("/login/"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    
                    let token = try JSONDecoder().decode(Token.self, from: data)
                    print("Success", token.getToken())
                    self.userDefaults.setValue("Token \(token.getToken())", forKey: "token")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController())
                    
                }catch{
                    print("CATCH: ", data)
                }
            }else{
                print("Error")
            }

        }
    }

    // This function returns an array of blood pressure readings
    func getBloodReadings(completion: @escaping([BloodPressureReading]?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]

        AF.request(self.baseURL.appendingPathComponent("/blood-pressure-readings/"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
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
    
    // This function sets blood pressure readings
    func postBloodReadings(newPressure: BloodPressureReading, completion: @escaping(BloodPressureReading?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]
        let parameters : Parameters = [ "pulse": newPressure.getPulse(),
                                        "systolic": newPressure.getSystolicReading(),
                                        "diastolic": newPressure.getDiastolicReading()]

        
        AF.request(self.baseURL.appendingPathComponent("/blood-pressure-readings/"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let data = response.data {
                do{
                    print(data)
                    let bloodPressureReading = try JSONDecoder().decode(BloodPressureReading.self, from: data)
                    completion(bloodPressureReading,nil)
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
