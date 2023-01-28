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
    
