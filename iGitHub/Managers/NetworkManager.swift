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
    let followers = "/followers?per_page=100&page="
    static let shared = NetworkManager()
    private init() {}
    
    func getUserDetails(with username: String, completion: @escaping(Result<User, GHError>)->()) {
        guard let url = URL(string: baseUrl + username) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, errorMessage) in
            if let _ = errorMessage {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let userData = try decoder.decode(User.self, from: data)
                completion(.success(userData))
                
            } catch {
                completion(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
    
    func getFollowersList(username: String, page: Int, completion: @escaping (Result<[Follower], GHError>) -> ()) {
        guard let url = URL(string: baseUrl + username + "\(followers)" + "\(page)") else {
                   completion(.failure(.invalidURL))
                   return
               }
         print(url)
               let task = URLSession.shared.dataTask(with: url) { (data, response, errorMessage) in
                   if let _ = errorMessage {
                       completion(.failure(.unableToComplete))
                       return
                   }
                   guard let response = response as? HTTPURLResponse,
                       response.statusCode == 200
                       else {
                           completion(.failure(.invalidResponse))
                       return
                   }
                   guard let data = data else {
                       completion(.failure(.invalidData))
                       return
                   }
                   do {
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .convertFromSnakeCase
                       let followers = try decoder.decode([Follower].self, from: data)
                       completion(.success(followers))
                       
                   } catch {
                       completion(.failure(.invalidResponse))
                   }
               }
               task.resume()
    }
    
}
