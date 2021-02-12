//
//  ReposViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

final class ReposViewController: GRDataLoadingViewController {
    
    var repos:          [Repo]  = []
    var filteredRepos:  [Repo]  = []
    var search:         String!
    var searches:       [RepoSearches] = []
    
    var page                    = 1
    var isSearching             = false
    var hasMoreRepos            = true
    var isLoadingMoreRepos      = false

    var collectionView:         UICollectionView!
    var dataSource:             UICollectionViewDiffableDataSource<Section, Repo>!
    
    var emptyStateContainerView = UIView()

    
// MARK: - Overrides & initialisers
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    init(search: String) {
        super.init(nibName: nil, bundle: nil)
        self.search = search
        title = "Results for '\(search)'"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - @objc functions
    
    @objc func addButtonTapped() {
        fetchSearches()
        
        for search in searches {
            if search.searchUrl == self.search {
                presentGRAlertOnMainThread(title: Constants.Strings.Title.alreadyFaved,
                                           message: Constants.Strings.Messages.alreadyFaved,
                                           buttonTitle: Constants.Strings.Title.ok)
                return
            }
        }
        
        let favouriteSearch = RepoSearches(context: DataControllerManager.shared.context)
        favouriteSearch.searchUrl = search
        DataControllerManager.shared.saveSearches()
        
        presentGRAlertOnMainThread(title: Constants.Strings.Title.faved,
                                   message: Constants.Strings.Messages.faved,
                                   buttonTitle: Constants.Strings.Title.ok)
    }
    
    
    private func fetchSearches() {
        DataControllerManager.shared.fetchSearches { result in
            switch result {
            case .success(let searches):
                self.searches = searches
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
// MARK: - Private Functions
    
    private func configure() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController?.navigationBar.tintColor           = .systemYellow
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        configureCollectionView()
        configureDataSource()
        configureSearchController()
        getRepos(search: search, page: page)
    }
    
    
    private func getRepos(search: String, page: Int) {
        showLoadingView()
        isLoadingMoreRepos = true
        
        NetworkManager.shared.getRepos(search: search, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let repos):
                self.updateUI(with: repos)
                
            case .failure(let error):
                self.presentGRAlertOnMainThread(title: Constants.Strings.Title.oops,
                                                message: error.rawValue,
                                                buttonTitle: Constants.Strings.Title.ok)
            }
            self.isLoadingMoreRepos = false
        }
    }
    
//MARK: - CollectionView configureations
    
    private func updateData(on repos: [Repo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Repo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(repos)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.collectionView.reloadData()
        }
    }
    
    
    private func updateUI(with repos: [Repo]) {
        if repos.count < 20 { self.hasMoreRepos = false } // checks of there are more followers in order to know if we can make anoether network call
        self.repos.append(contentsOf: repos)
        
        if self.repos.isEmpty {
            configureEmptyStateViewOnMainThread()
            return
        }
        DispatchQueue.main.async {
            self.emptyStateContainerView.removeFromSuperview()
        }
        self.updateData(on: self.repos)
    }
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Repo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, error -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GRCollectionViewCell.reuseID, for: indexPath) as! GRCollectionViewCell
            cell.set(repo: self.repos[indexPath.row])
            return cell
        })
    }
    
    
    private func configureCollectionView() {
        collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnCompositionlalayout())
        collectionView.backgroundColor  = .systemBackground
        collectionView.delegate         = self
        collectionView.register(GRCollectionViewCell.self, forCellWithReuseIdentifier: GRCollectionViewCell.reuseID)
        view.addSubview(collectionView)
    }

    
// MARK: - UIConfigurations
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = Constants.Strings.Title.searchRepos
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    private func configureEmptyStateViewOnMainThread() {
        DispatchQueue.main.async {
            self.emptyStateContainerView.frame = self.view.bounds
            self.view.addSubview(self.emptyStateContainerView)
            self.showEmptyStateView(with: Constants.Strings.Messages.emptyRepo, in: self.emptyStateContainerView)
        }
    }
}


// MARK: - Extensions

extension ReposViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreRepos, !isLoadingMoreRepos else { return }
            page += 1
            getRepos(search: search, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(UINavigationController(rootViewController: RepoDetailViewController(repo: repos[indexPath.row])), animated: true)
    }
}

extension ReposViewController: UISearchResultsUpdating {
        func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredRepos.removeAll()
            updateData(on: repos)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredRepos = repos.filter { $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredRepos)
    }
    
}
