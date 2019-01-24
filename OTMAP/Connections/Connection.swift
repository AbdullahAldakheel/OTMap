
//  Connection.swift
//  OTMAP
//
//  Created by Abdullah Aldakhiel on 11/01/2019.
//  Copyright © 2019 Abdullah Aldakhiel. All rights reserved.
//
import UIKit
import Foundation


class Connection: UIViewController {

  static var sessionUser: String? = nil
     static var userInfo = UserInfo()
     static var statusLogIn:String!

    
    static func login_now(username:String, password:String, completion: @escaping (String?)->Void) {
        

        
        
        let parameters = ["username": username, "password": password]
        let udacity = ["udacity": parameters]
        let url = URL(string: "https://onthemap-api.udacity.com/v1/session")!
        let session = URLSession.shared
        var back = ""
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: udacity, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
     
        let task = session.dataTask(with: request) { data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode >= 200 && statusCode < 300 {
                    
                    let newData = data?.subdata(in: 5..<data!.count)
                    if let json = try? JSONSerialization.jsonObject(with: newData!, options: []),
                        let dict = json as? [String:Any],
                        let sessionDict = dict["session"] as? [String: Any],
                        let accountDict = dict["account"] as? [String: Any]  {
                        
                        self.userInfo.key  = accountDict["key"] as? String
                        self.sessionUser = sessionDict["id"] as? String
                    } else {
                       back = "error"
                    }
                    
                    
                } else {
                  back = "error"
                }
            } else {
               back = "error"
            }
            DispatchQueue.main.async {
                completion(back)
            }
            
        }
        
        task.resume()
       
    }
        
        static func getUserLocations(limit: Int = 100, skip: Int = 0, orderBy: SLParam = .updatedAt, completion: @escaping (locationInfo?)->Void) {
            let url = URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")! //change the url
            let session = URLSession.shared
            var request = URLRequest(url: url)
            
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")

            let task = session.dataTask(with: request) { data, response, error in
                var studentLocations: [StudentInfo] = []
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode >= 200 && statusCode < 300 {
                        
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []),
                            let dict = json as? [String:Any],
                            let results = dict["results"] as? [Any] {
                            
                            for location in results {
                                let data = try! JSONSerialization.data(withJSONObject: location)
                                let studentLocation = try! JSONDecoder().decode(StudentInfo.self, from: data)
                                studentLocations.append(studentLocation)
                            }
                            
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    completion(locationInfo(studentInfo: studentLocations))
                }
                
            }
            task.resume()
        }
    
    static func addLocation(_ location: StudentInfo, completion: @escaping (String?)->Void) {
        let parameters1 = ["uniqueKey": location.uniqueKey, "firstName": location.firstName, "lastName": location.lastName, "mapString": location.mapString, "mediaURL": location.mediaURL, "latitude": location.latitude, "longitude": location.longitude] as [String : Any]

        
            
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters1, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        
        DispatchQueue.main.async {
            completion("")
        }
        task.resume()
    }
    
    
}
