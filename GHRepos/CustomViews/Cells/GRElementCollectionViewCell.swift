//
//  GRElementCollectionViewCell.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRElementCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ElementCellID"
    
    var titleLabel  = GRTitleLabel(textAlignment: .left, fontSize: 22, textColor: .label)
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
            titleLabel.text = Constants.Strings.ElementTitles.language
            imageView.image = Constants.Images.ElementImages.language
            countLabel.text = repo.language
            
        case 1:
            titleLabel.text = Constants.Strings.ElementTitles.score
            imageView.image = Constants.Images.ElementImages.score
            countLabel.text = "\(repo.score)"
            
        case 2:
            titleLabel.text = Constants.Strings.ElementTitles.forks
            imageView.image = Constants.Images.ElementImages.forks
            countLabel.text = "\(repo.forksCount)"
            
        case 3:
            titleLabel.text = Constants.Strings.ElementTitles.issues
            imageView.image = Constants.Images.ElementImages.issues
            countLabel.text = "\(repo.openIssuesCount)"
            
        case 4:
            titleLabel.text = Constants.Strings.ElementTitles.watchers
            imageView.image = Constants.Images.ElementImages.watchers
            countLabel.text = "\(repo.watchersCount)"
            
        default:
            titleLabel.text = Constants.Strings.Title.oops
            imageView.image = UIImage(systemName: "")
            countLabel.text = Constants.Strings.Title.somethingsWrong
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
