//
//  Character.swift
//  Rick and morty
//
//  Created by Наталья Миронова on 25.01.2023.
//
import Foundation

struct CharacterApp: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let location: LastLocation
    let image: String
    let episode: [String]
}

struct LastLocation: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
}

