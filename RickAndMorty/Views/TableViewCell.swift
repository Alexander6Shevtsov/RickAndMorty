//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Alexander Shevtsov on 18.11.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public Methods
    func configure(with character: Character?) {
        guard let character else { return }
        nameLabel.text = character.name
        networkManager.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

