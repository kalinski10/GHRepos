//
//  GRElementCollectionViewCell.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRElementCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ElementCellID"
    
    var titleLabel  = GRTitleLabel(textAlignment: .left, fontSize: 22)
    var imageView   = UIImageView()
    var countLabel  = GRBodyLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
        layer.cornerRadius = 10
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(repo: Repo, indexPath: Int) {
        switch indexPath {
        case 0:
            titleLabel.text = "Language:"
            imageView.image = UIImage(systemName: "captions.bubble.fill")
            countLabel.text = repo.language
            
        case 1:
            titleLabel.text = "Score:"
            imageView.image = UIImage(systemName: "star.fill")
            countLabel.text = "\(repo.score)"
            
        case 2:
            titleLabel.text = "Forks:"
            imageView.image = UIImage(systemName: "tuningfork")
            countLabel.text = "\(repo.forksCount)"
            
        case 3:
            titleLabel.text = "Issues:"
            imageView.image = UIImage(systemName: "staroflife.fill")
            countLabel.text = "\(repo.openIssuesCount)"
            
        case 4:
            titleLabel.text = "Watchers:"
            imageView.image = UIImage(systemName: "eye.fill")
            countLabel.text = "\(repo.watchersCount)"
            
        default:
            titleLabel.text = "Oops:"
            imageView.image = UIImage(systemName: "")
            countLabel.text = "something went wrong"
        }
    }
    
    
    private func configure() {
        addSubviews(titleLabel, imageView, countLabel)
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding*2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
        
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            countLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            countLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            countLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
