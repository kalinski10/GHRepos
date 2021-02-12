//
//  GRCollectionViewCell.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

class GRCollectionViewCell: UICollectionViewCell {

    static let reuseID = "collectoinViewCellID"
    
    let image = GRAvatarImageView(frame: .zero)
    let title = GRTitleLabel(textAlignment: .center, fontSize: 16, textColor: .label)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(repo: Repo) {
        image.downloadImage(fromURL: repo.owner.avatarUrl)
        title.text = repo.name
    }
    
    
    private func configureLayout() {
        layer.cornerRadius = 10
        addSubviews(image, title)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
