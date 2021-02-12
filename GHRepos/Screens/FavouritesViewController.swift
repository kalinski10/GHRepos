//
//  FavouritesViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

final class FavouritesViewController: UIViewController {

    var emptyStateContainerView = UIView()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RepoSearches>!
    
    var searches: [RepoSearches] = []
    
// MARK: - Overrides & initialisers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurations()
    }
    
    
    private func configurations() {
        configureCollectionView()
        fetchSearches()
    }
    
// MARK: - Private Functions
    
    private func updateData(with searches: [RepoSearches]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, RepoSearches>()
        snapShot.appendSections([.main])
        snapShot.appendItems(searches)
        DispatchQueue.main.async { self.dataSource.apply(snapShot) }
    }
    
    
    private func fetchSearches() {
        DataControllerManager.shared.fetchSearches { result in
            switch result {
            case .success(let searches):
                self.searches = searches
                self.updateData(with: searches)
                self.updateUI()
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    private func updateUI() {
        if searches.isEmpty {
            configureEmptyStateViewOnMainThread()
        } else {
            DispatchQueue.main.async {
                self.emptyStateContainerView.removeFromSuperview()
            }
        }
    }
    
    
    private func configureEmptyStateViewOnMainThread() {
        DispatchQueue.main.async {
            self.emptyStateContainerView.frame = self.view.bounds
            self.view.addSubview(self.emptyStateContainerView)
            self.showEmptyStateView(with: Constants.Strings.Messages.noFaves, in: self.emptyStateContainerView)
        }
    }
    
    
// MARK: - CollectionView Configurrations

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureCollectionListCompositionalLayout())
        collectionView.delegate = self
        view.addSubviews(collectionView)
        
        let reg = UICollectionView.CellRegistration<UICollectionViewListCell, RepoSearches> {
            cell, indexPath, search in
            
            var content                 = UIListContentConfiguration.valueCell()
            content.text                = search.searchUrl
            cell.contentConfiguration   = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, RepoSearches>(collectionView: collectionView, cellProvider: { collectionView, indexPath, search in
            collectionView.dequeueConfiguredReusableCell(using: reg, for: indexPath, item: search)
        })
    }
    
    
    private func configureCollectionListCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.trailingSwipeActionsConfigurationProvider = { [unowned self] indexpath in
            return self.configureTrailingSwipeAction(indexPath: indexpath)
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    
    private func configureTrailingSwipeAction(indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.Strings.Title.delete) { [unowned self] action, view, completionHandler in
            
            let searchToRemove = self.searches[indexPath.row]
            
            DataControllerManager.shared.context.delete(searchToRemove)
            DataControllerManager.shared.saveSearches()
            
            self.searches.remove(at: indexPath.row)
            self.fetchSearches()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}


extension FavouritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ReposViewController(search: searches[indexPath.row].searchUrl!), animated: true)
    }
    
}
