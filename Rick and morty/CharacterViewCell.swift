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
        infoCharacterLabel.text = "\(character.status) - \(character.species)\n\n \(character.location.name)\n\n"
        NetworkManager.shared.fetchImage(from: character.image) { [self] data in
            self.imageCharacterView.image = UIImage(data: data)
            
            //let episode = character.episode[0]
            
            NetworkManager.shared.fetch(dataType: Episode.self, url: character.episode[0]) { episode in
                self.infoCharacterLabel.text = "\(character.status) - \(character.species)\n\n \(character.location.name)\n\n \(episode.name)"
            }
            
            }
        }
    override func prepareForReuse() {
        imageCharacterView.image = nil
    }
    
    }
    
    

