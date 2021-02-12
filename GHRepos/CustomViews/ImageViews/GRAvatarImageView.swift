//
//  GRAvatarImageView.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRAvatarImageView: UIImageView {
    
    let cache            = NetworkManager.shared.cache
    let placeholderImage = Constants.Images.avatarPlaceHolderImage
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
