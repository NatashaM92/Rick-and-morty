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
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(T) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(type)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    
    private init() {}
}
