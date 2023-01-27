//
//  ViewController.swift
//  Rick and morty
//
//  Created by Наталья Миронова on 25.01.2023.
//

import UIKit

class CharactersViewController: UICollectionViewController {
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    
    
    private func fetchCharacters() {
        NetworkManager.shared.fetch(dataType: CharacterApp.self ,url: Link.url.rawValue) { characterApp in
            self.characters = characterApp.results
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource

extension CharactersViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "character", for: indexPath) as? CharacterViewCell else { return UICollectionViewCell() }
        
        let character = characters[indexPath.item]
        
        cell.configur(character: character)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 180)
    }
}
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchCharacters()
//    }


//extension CharactersViewController {
//
//    private func fetchCharacters() {
//        guard let url = URL(string: Link.url.rawValue) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//
//            guard let data = data else {
//                print(error?.localizedDescription ?? "no error description")
//                return
//            }
//
//            do {
//                let characters = try JSONDecoder().decode(CharacterApp.self, from: data)
//                print(characters)
//
//            } catch let error {
//                print(error)
//            }
//        } .resume()
//    }
//}
