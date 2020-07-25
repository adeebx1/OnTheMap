//
//  OnTheMapClient.swift
//  OnTheMap
//
//  Created by Adeeb alsuhaibani on 30/11/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation

class OnTheMapClient {
    
    struct authInfo {
        static var accountKey = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case login
        case getStudentLocation
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case .login: return Endpoints.base + "/session"
            case .getStudentLocation: return Endpoints.base + "/StudentLocation?order=-updatedAt&limit=100"
            case .postStudentLocation: return Endpoints.base + "/StudentLocation"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    
    class func login (username: String, password: String , completion: @escaping (Bool, Error?) -> Void ) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range) /* subset response data! */
                let responseObject = try decoder.decode(SessionRespones.self, from: newData)
                
                authInfo.accountKey = responseObject.account.key
                authInfo.sessionId = responseObject.session.id
                DispatchQueue.main.async {
                    completion(true, error)
                    
                }
            }
            catch {
                do {
                    let errorResponse = try decoder.decode(SessionRespones.self, from: data) as! Error
                    DispatchQueue.main.async {
                        completion(false, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                }
            }
        }
        task.resume()
        
    }
    
    class func getStudentLocation(completion: @escaping ([StudentLocation], Error?) -> Void ) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(StudentLocationResults.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
        
        
    }
    
    
    class func postStudentLocation (studentLocation:StudentLocation , completion: @escaping (Bool, Error?) -> Void ) {
        var request = URLRequest(url: Endpoints.postStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(studentLocation.uniqueKey)\", \"firstName\": \"\(studentLocation.firstName)\", \"lastName\": \"\(studentLocation.lastName)\",\"mapString\": \"\(studentLocation.mapString)\", \"mediaURL\": \"\(studentLocation.mediaURL)\",\"latitude\": \(studentLocation.latitude), \"longitude\": \(studentLocation.longitude)}".data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(false, error)
                return
            }
            print(String(data: data, encoding: .utf8)!)
            completion(true, error)
        }
            task.resume()
        }
    
        
        class func deleteSession(completion: @escaping (Bool, Error?) -> Void ){
            var request = URLRequest(url: Endpoints.login.url)
            request.httpMethod = "DELETE"
            var xsrfCookie: HTTPCookie? = nil
            let sharedCookieStorage = HTTPCookieStorage.shared
            for cookie in sharedCookieStorage.cookies! {
                if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            }
            if let xsrfCookie = xsrfCookie {
                request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil { // Handle error…
                    return
                }
                let range = 5..<data!.count
                let newData = data!.subdata(in: range)
                print(String(data: newData, encoding: .utf8)!)
                completion(true,nil)
            }
            task.resume()
            
        }
}
