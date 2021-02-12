//
//  OwnerCardView.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

protocol GetProfileDelegate {
    func buttonTapped(with url: String)
}

class OwnerCardView: UIView {
    
    let imageView           = GRAvatarImageView(frame: .zero)
    let name                = GRTitleLabel(textAlignment: .center, fontSize: 24, textColor: .label)
    let button              = GRButton(backgroundColor: .systemYellow , title: "View Owner Profile")
    
    var getProfileUrl       = ""
    
    var delegate: GetProfileDelegate!
    
// MARK: - Overrides and Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(owner: User) {
        imageView.downloadImage(fromURL: owner.avatarUrl)
        name.text           = owner.login
        getProfileUrl       = owner.htmlUrl
    }
    
// MARK: - @objc Functions
    
    @objc func getProfileTapped() {
        delegate.buttonTapped(with: getProfileUrl)
    }
    
// MARK: - private functions
    
    private func configure() {
        layer.cornerRadius  = 15
        backgroundColor     = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(imageView, name, button)
        uiLayout()
        button.addTarget(self, action: #selector(getProfileTapped), for: .touchUpInside)
    }
    
// MARK: - UISetup
    
    private func uiLayout() {
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            name.topAnchor.constraint(equalTo: imageView.topAnchor),
            name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            name.heightAnchor.constraint(equalToConstant: 30),
            
            // if the Layout doesnt work i could a put it in a container
            button.topAnchor.constraint(equalTo: name.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
    }
    
}
