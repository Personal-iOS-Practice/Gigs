//
//  GigController.swift
//  Gigs
//
//  Created by Waseem Idelbi on 6/6/22.
//

import Foundation

enum NetworkError: Error {
    case failedSignIn
    case failedSignUp
    case noData
    case noToken
    case noDecode
    case noEncode
}

class GigController {
    
//MARK: - Properties
    var bearer: Bearer?
    var baseURL = URL(string: "https://lambdagigapi.herokuapp.com/api/users")!
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
//MARK: - Methods
    // creates a POST request
    func postRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    // Create an account for a new user
    func signUp(userName: String, password: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let user = User(username: userName, password: password)
        var request = postRequest(with: baseURL.appendingPathComponent("signup"))
        
        do {
            let userData = try encoder.encode(user)
            request.httpBody = userData
        } catch {
            print("ERROR: Could not convert user info to data, error: \(error)")
            completion(.failure(.noEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("ERROR: Could not create account for user! error: \(error)")
                completion(.failure(.failedSignUp))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("ERROR: Could not create account for user!")
                completion(.failure(.failedSignUp))
                return
            }
            
            completion(.success(true))
        }
        .resume()
    }
    // Sign into an existing user's existing account
    func sighIn(userName: String, password: String, completion: @escaping (Error?) -> Void) {
        
    }
    
}
