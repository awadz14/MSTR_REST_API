//
//  ViewController.swift
//  URLSessionJSONRequests
//
//  Created by Kyle Lee on 4/23/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

private var authtoken = ""


class ViewController: UIViewController {

    
    @IBAction func onGetTapped(_ sender: Any) {
        

        guard let url = URL(string: "https://demo.microstrategy.com/MicroStrategyLibrary/api/projects") else { return }
        var request = URLRequest(url: url)
        request.addValue(authtoken, forHTTPHeaderField: "X-MSTR-AuthToken")

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    
    @IBAction func onPostTapped(_ sender: Any) {
        
        let parameters = ["username": "guest", "password": ""]
        
        guard let url = URL(string: "https://demo.microstrategy.com/MicroStrategyLibrary/api/auth/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                if let httpResponse = response as? HTTPURLResponse {
                    authtoken = httpResponse.allHeaderFields["x-mstr-authtoken"] as! String
                    print("x-mstr-authtoken: " + authtoken)
                    
                }
                //print(response)
            }
            
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch {
//                    print(error)
//                }
//            }
            
        }.resume()
        
    }
    
    
}



















