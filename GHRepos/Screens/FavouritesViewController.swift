//
//  FavouritesViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

class FavouritesViewController: UIViewController {

    var text = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurations()
    }

    
    func configurations() {
        view.addSubviews(text)
        configureText()
    }
    
    
    func configureText() {
        text.text               = "FavouritesVC"
        text.layer.borderWidth  = 2
        text.layer.borderColor  = UIColor.black.cgColor
        text.textAlignment      = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.heightAnchor.constraint(equalToConstant: 50),
            text.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
}
