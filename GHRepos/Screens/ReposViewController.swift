//
//  ReposViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

class ReposViewController: GRDataLoadingViewController {
    
    var repos:          [Repo]  = []
    var filteredRepos:  [Repo]  = []
    var search:         String!
    
    var page                    = 1
    var isSearching             = false
    var hasMoreRepos            = true
    var isLoadingMoreRepos      = false

    var collectionView:         UICollectionView!
    var dataSource:             UICollectionViewDiffableDataSource<Section, Repo>!

    
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
    
    
// MARK: - Private Functions
    
    private func configure() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
                print(error.rawValue)
            }
            self.isLoadingMoreRepos = false
        }
    }
    
//MARK: - CollectionView configureations
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Repo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, error -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GRCollectionViewCell.reuseID, for: indexPath) as! GRCollectionViewCell
            cell.set(repo: self.repos[indexPath.row])
            return cell
        })
    }
    
    
    private func updateData(on repos: [Repo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Repo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(repos)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.collectionView.reloadData()
        }
    }
    
    func updateUI(with repos: [Repo]) {
        if repos.count < 20 { self.hasMoreRepos = false } // checks of there are more followers in order to know if we can make anoether network call
        self.repos.append(contentsOf: repos)
        
        if self.repos.isEmpty {
            let message = "This User doesnt have any followers. Go follow them!"
            print(message)
//            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.repos)
    }
    

    
// MARK: - UIConfigurations
    
    private func configureCollectionView() {
        collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnCompositionlalayout())
        collectionView.backgroundColor  = .systemBackground
        collectionView.delegate         = self
        collectionView.register(GRCollectionViewCell.self, forCellWithReuseIdentifier: GRCollectionViewCell.reuseID)
        view.addSubview(collectionView)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search For Repository"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
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
