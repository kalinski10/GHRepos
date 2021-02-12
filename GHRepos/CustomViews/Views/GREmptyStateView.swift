//
//  GREmptyStateView.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 12/02/2021.
//

import UIKit

class GREmptyStateView: UIView {
    
    let title               = GRTitleLabel(textAlignment: .center, fontSize: 30, textColor: .systemGray2)
    let imageView           = UIImageView()
    let padding: CGFloat    = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureVIew()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message title: String) {
        self.init(frame: .zero)
        self.title.text     = title
    }
    
    
    private func configureVIew() {
        addSubviews(title, imageView)
        backgroundColor     = .systemBackground
        
        imageView.image     = Constants.Images.emptyStateImage
        imageView.tintColor = .systemGray2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 100),
            imageView.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: 140),
            imageView.widthAnchor.constraint(equalTo: title.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
    }
    
}
