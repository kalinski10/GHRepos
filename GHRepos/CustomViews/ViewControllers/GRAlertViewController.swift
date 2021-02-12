//
//  GRAlertViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRAlertViewController: UIViewController {
    
    // MARK: - Constants
        
        let containerView       = GRAlertContainerView()
        let titleLabel          = GRTitleLabel(textAlignment: .center, fontSize: 20)
        let messageLabel        = GRBodyLabel(textAlignment: .center)
        let actionButton        = GRButton(backgroundColor: .systemYellow, title: "OK")
        
        let padding: CGFloat    = 20

    // MARK: - Properties
        
        var alertTitle:     String?
        var message:        String?
        var buttonTitle:    String?
        
    // MARK: - Overrides and Init
        
        init(title: String, message: String, buttonTitle: String) {
            super.init(nibName: nil, bundle: nil)
            self.alertTitle     = title
            self.message        = message
            self.buttonTitle    = buttonTitle
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            containerView.addSubviews(titleLabel, messageLabel, actionButton)
            
            configureContainerView()
            configureMessageLabel()
            configureActionButton()
            configureBodyLabel()
        }
        
    // MARK: - @objc functions
        
        @objc func dismissVC() {
            dismiss(animated: true)
        }
        
    // MARK: - Layout Configureations
        
        func configureContainerView() {
            view.addSubview(containerView)
            
            NSLayoutConstraint.activate([
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.widthAnchor.constraint(equalToConstant: 280),
                containerView.heightAnchor.constraint(equalToConstant: 220)
            ])
        }
        
        
        func configureMessageLabel() {
            titleLabel.text = alertTitle ?? "something went wrong" // this is called nil coalescing and its another way of unwrapping optionals
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                titleLabel.heightAnchor.constraint(equalToConstant: 28)
            ])
        }
        
        
        func configureActionButton() {
            actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
            actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
                actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                actionButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
        
        
        func configureBodyLabel() {
            messageLabel.text = message ?? "unable to comlete request"
            messageLabel.numberOfLines = 4
            
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 12)
            ])
        }
    }
