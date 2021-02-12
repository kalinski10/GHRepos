//
//  GRRepoElementsViewController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit

class GRRepoElementsViewController: UIViewController {

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    var elemetnsArray = Array(1...5)
    
    var repo: Repo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
        updateData(on: elemetnsArray)
    }


    init(repo: Repo) {
        super.init(nibName: nil, bundle: nil)
        self.repo = repo
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.configureTwoColumnHorizontalCompositionalLayout())
        collectionView.register(GRElementCollectionViewCell.self, forCellWithReuseIdentifier: GRElementCollectionViewCell.reuseID)
        collectionView.backgroundColor = .systemGray5
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view)
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, error -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GRElementCollectionViewCell.reuseID, for: indexPath) as! GRElementCollectionViewCell
            cell.set(repo: self.repo, indexPath: indexPath.row)
            return cell
        })
    }
    
    private func updateData(on elements: [Int]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(elements)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
            self.collectionView.reloadData()
        }
    }
    
}
