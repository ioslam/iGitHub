//
//  NetworkManager.swift
//  iGitHub
//
//  Created by Eslam on 7/10/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import Foundation
class NetworkManager {
    
    let baseUrl = "https://api.github.com/users/"
    
    static let shared = NetworkManager()
    private init() {}
    
    func getUserDetails(with username: String, completion: @escaping(_ error: ErrorMessage? ,_ user: User?)->()) {
        guard let url = URL(string: baseUrl + username) else {
            completion(.invalidURL, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, errorMessage) in
            if let _ = errorMessage {
                completion(.unableToComplete, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    completion(.invalidResponse, nil)
                return
            }
            guard let data = data else {
                completion(.invalidData, nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userData = try decoder.decode(User.self, from: data)
                completion(nil, userData)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
