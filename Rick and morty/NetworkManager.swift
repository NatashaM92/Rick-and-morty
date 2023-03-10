//
//  NetworkManager.swift
//  Rick and morty
//
//  Created by Наталья Миронова on 25.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link: String {
    case url = "https://rickandmortyapi.com/api/character"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
