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
    var gigs: [Gig] = []
    var bearer: Bearer?
    var authenticationBaseURL = URL(string: "https://lambdagigapi.herokuapp.com/api/users")!
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
    func signUp(username: String, password: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let user = User(username: username, password: password)
        var request = postRequest(with: authenticationBaseURL.appendingPathComponent("signup"))
        
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
    func sighIn(username: String, password: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        let user = User(username: username, password: password)
        var request = postRequest(with: authenticationBaseURL.appendingPathComponent("login"))
        
        do {
            request.httpBody = try encoder.encode(user)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("ERROR: Sign in failed with error: \(error.localizedDescription)")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    print("Sign in failed!")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let data = data else {
                    print("Data not found!")
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    self.bearer = try self.decoder.decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("ERROR: Couldn't decode bearer with error: \(error.localizedDescription)")
                    completion(.failure(.noToken))
                    return
                }
                
            }
            .resume()
            
        } catch {
            print("ERROR: Could not encode user into data")
            completion(.failure(.noEncode))
            return
        }
        
    }
    // Fetch gigs from API
    
    
}
