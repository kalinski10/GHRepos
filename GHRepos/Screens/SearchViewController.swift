//
//  SearchViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let image           = UIImageView()
    let textField       = GRTextField()
    let searchButton    = GRButton(backgroundColor: .systemYellow, title: Constants.Strings.Title.search)
    
    var isSearchEntered: Bool { return !textField.text!.isEmpty }
    
    
// MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        textField.text = ""
    }
    
// MARK: - Private functions
    
    private func configurations() {
        view.addSubviews(image, textField, searchButton)
        configureImage()
        configureTextField()
        configureButton()
        keyeboardDissmiser()
    }
    
    
    private func keyeboardDissmiser() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
//MARK: - @objc Functions
    
    @objc func pushReposVC() {
        guard isSearchEntered else {
            presentGRAlertOnMainThread(title: Constants.Strings.Title.emptySearch,
                                       message: Constants.Strings.Messages.inputRepo,
                                       buttonTitle: Constants.Strings.Title.ok)
            return
        }

        textField.resignFirstResponder()
        navigationController?.pushViewController(ReposViewController(search: textField.text!), animated: true)
    }
    
    
// MARK: - UIConfigureations
    
    private func configureImage() {
        image.image = Constants.Images.ghLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureTextField() {
        textField.delegate = self
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            textField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalToConstant: 258)
        ])
    }
    
    
    private func configureButton() {
        searchButton.addTarget(self, action: #selector(pushReposVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 258)
        ])
    }
    
}


//MARK: - Extensions

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushReposVC()
        return true
    }
}
