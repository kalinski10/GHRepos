//
//  FavouritesViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

class FavouritesViewController: UIViewController {

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Repo>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurations()
    }

    
    func configurations() {

    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.configureThreeColumnCompositionlalayout())
        collectionView.backgroundColor = .red
        
        
        
    }
    
}
