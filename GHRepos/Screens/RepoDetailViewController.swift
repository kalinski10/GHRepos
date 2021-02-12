//
//  GRRepoInfoViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class RepoDetailViewController: UIViewController {

    let titleLabel          = GRTitleLabel(textAlignment: .left, fontSize: 30, textColor: .label)
    let descriptionLabel    = GRBodyLabel()
    let readMeLabel         = UIButton()
    let containerView       = UIView() // for the child vc
    let createdAtLable      = GRSecondaryTitleLabel(fontSize: 18, textAlignment: .center)
    let ownerCard           = OwnerCardView()
    
    var repo: Repo!
    
// MARK: - Overrides & initialisers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    init(repo: Repo) {
        super.init(nibName: nil, bundle: nil)
        ownerCard.set(owner: repo.owner)
        self.repo = repo
        titleLabel.text         = repo.name
        createdAtLable.text     = "Created on the \(repo.createdAt.convertToMonthYearFormat())"
        descriptionLabel.text   = repo.description ?? "No description to show"
        add(childVC: GRRepoElementsViewController(repo: repo), to: containerView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - @objc functions
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func readMeTapped() {
        presentSafariVC(url: URL(string: repo.htmlUrl)!)
    }

    
// MARK: - Private funtions
    
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        view.addSubviews(ownerCard, titleLabel, descriptionLabel, readMeLabel, containerView, createdAtLable)
        
        ownerCard.delegate = self
        configureReadMe()
        configureContainerView()
        uiLayout()
    }
    
    func add(childVC: UIViewController, to containerView: UIView) { // this is how we add the child vc to a container
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

    private func configureReadMe() {
        readMeLabel.setTitle("Click here to view README", for: .normal)
        readMeLabel.setTitleColor(.systemYellow, for: .normal)
        readMeLabel.titleLabel?.font            = UIFont.systemFont(ofSize: 14)
        readMeLabel.titleLabel?.textAlignment   = .left
        readMeLabel.translatesAutoresizingMaskIntoConstraints = false
        readMeLabel.addTarget(self, action: #selector(readMeTapped), for: .touchUpInside)
    }
    
    
    private func configureContainerView() {
        containerView.backgroundColor       = .systemGray5
        containerView.layer.cornerRadius    = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
// MARK: - Layout Configurations
    
    private func uiLayout() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 70),
            
            readMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            readMeLabel.widthAnchor.constraint(equalToConstant: 185),
            readMeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            readMeLabel.heightAnchor.constraint(equalToConstant: 22),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.topAnchor.constraint(equalTo: readMeLabel.bottomAnchor),
            
            createdAtLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createdAtLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createdAtLable.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: padding),
            createdAtLable.heightAnchor.constraint(equalToConstant: 50),
            
            ownerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ownerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ownerCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            ownerCard.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    
}


extension RepoDetailViewController: GetProfileDelegate {
    func buttonTapped(with url: String) {
        presentSafariVC(url: URL(string: url)!)
    }
    
}
