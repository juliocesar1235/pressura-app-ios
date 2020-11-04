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
    
    // This function returns an array of blood pressure readings
    func getBloodReadings(completion: @escaping([BloodPressureReading]?, String?) -> Void){
        AF.request(self.baseURL.appendingPathComponent("/blood-pressure-readings"), method: .get, parameters: nil, encoding: URLEncoding.httpBody).responseJSON {
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
}
