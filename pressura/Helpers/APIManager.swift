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

    // Create new account
    func signUp(username: String, firstName: String, lastName: String, email: String, password: String, completion: @escaping(String?, String?) -> Void) {
        let params = [
            "username": username,
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "password": password
        ] as Parameters

        AF.request(self.baseURL.appendingPathComponent("/sign-up/"), method: .post, parameters: params, encoding: URLEncoding.httpBody).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let token = try JSONDecoder().decode(Token.self, from: data)
                    let tokenString = "Token \(token.getToken())"
                    self.userDefaults.setValue(tokenString, forKey: "token")
                    completion(tokenString, nil)
                } catch{
                    completion(nil, "Decoding error")
                }
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
            }
        }
    }

    // Login with given username and password
    func login(username: String, password: String, completion: @escaping(String?, String?) -> Void){
        let headers : HTTPHeaders = [.accept("application/json")]
        let parameters : Parameters = [ "username": username, "password": password]

        AF.request(self.baseURL.appendingPathComponent("/login/"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let token = try JSONDecoder().decode(Token.self, from: data)
                    let tokenString = "Token \(token.getToken())"
                    self.userDefaults.setValue(tokenString, forKey: "token")
                    completion(tokenString, nil)
                } catch{
                    completion(nil, "Decoding error")
                }
            } else if let statusCode = response.response?.statusCode, statusCode - 400 < 100 {
                completion(nil, "Has mandado credenciales incorrectas. Revisa tus datos e intenta de nuevo 🤔")
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
            }

        }
    }
    
    // Get user information with given token
    func getUser(completion: @escaping(User?, String?)->Void) {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]

        AF.request(self.baseURL.appendingPathComponent("/user/"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let user = try JSONDecoder().decode(User.self, from: data)
                    try self.userDefaults.setObject(user, forKey: "user")
                    completion(user, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            } else if let statusCode = response.response?.statusCode, statusCode - 400 < 100 {
                completion(nil, "Usuario no encontrado 🤔")
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
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
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let bloodPressureReadings = try JSONDecoder().decode([BloodPressureReading].self, from: data)
                    completion(bloodPressureReadings,nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            } else if let statusCode = response.response?.statusCode, statusCode - 400 < 100 {
                completion(nil, "Lecturas no encontrado 🤔")
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
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
        let parameters = [
            "pulse": newPressure.getPulse(),
            "systolic": newPressure.getSystolicReading(),
            "diastolic": newPressure.getDiastolicReading()
        ] as Parameters

        
        AF.request(self.baseURL.appendingPathComponent("/blood-pressure-readings/"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let bloodPressureReading = try JSONDecoder().decode(BloodPressureReading.self, from: data)
                    completion(bloodPressureReading, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
            }
        }
    }


    // Get readings for general health
    func getGeneralHealthReadings(completion: @escaping([GeneralHealthReading]?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]
        AF.request(self.baseURL.appendingPathComponent("/general-health-readings/"), method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let generalHealthReadings = try JSONDecoder().decode([GeneralHealthReading].self, from: data)
                    completion(generalHealthReadings, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            } else if let statusCode = response.response?.statusCode, statusCode - 400 < 100 {
                completion(nil, "Lecturas no encontrado 🤔")
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
            }
        }

    }
    
    // This function sets general health readings
    func postGeneralHealthReadings(newHealthReading: GeneralHealthReading, completion: @escaping(GeneralHealthReading?, String?) -> Void){
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let headers : HTTPHeaders = [
            .authorization(token!),
            .accept("application/json")
        ]
        let parameters = [
            "weight" : newHealthReading.getWeight(),
            "abdominal_circumference": newHealthReading.getAbdominalCircumference(),
            "treatment_compliance": newHealthReading.getTreatmentComplience(),
            "exercise_compliance": newHealthReading.getExerciseCompliance(),
            "diet_compliance": newHealthReading.getDietComplience(),
            "comment": newHealthReading.getComment()
        ] as Parameters

        
        AF.request(self.baseURL.appendingPathComponent("/general-health-readings/"), method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON {
            (response) in
            if let statusCode = response.response?.statusCode, statusCode - 200 < 100, let data = response.data {
                do{
                    let healthReding = try JSONDecoder().decode(GeneralHealthReading.self, from: data)
                    completion(healthReding, nil)
                }catch{
                    completion(nil, "Decoding error")
                }
            } else {
                completion(nil, "Ha ocurrido un error en el servidor. Intenta de nuevo más tarde 🤞")
            }
        }
    }
}
