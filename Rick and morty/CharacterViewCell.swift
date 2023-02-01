//
//  CharacterViewCell.swift
//  Rick and morty
//
//  Created by Наталья Миронова on 27.01.2023.
//
import UIKit

class CharacterViewCell: UICollectionViewCell {
    
    @IBOutlet var imageCharacterView: UIImageView!
    
    @IBOutlet var nameCharacterLabel: UILabel!
    @IBOutlet var infoCharacterLabel: UILabel!
    
    func configur(character: Character) {

        nameCharacterLabel.text = character.name
        
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let data):
                self?.imageCharacterView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
        
        NetworkManager.shared.fetch(dataType: Episode.self, url: character.episode[0]) { result in
            switch result {
            case .success(let episode):
                self.infoCharacterLabel.text = "\(character.status) - \(character.species)\n\n \(character.location.name)\n\n \(episode.name)"
            case .failure(let error):
                print(error)
            }
        }
    }
}
//    override func prepareForReuse() {
//        imageCharacterView.image = nil
//    }


    

