//
//  UIHelper.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit

enum Section { case main }

enum UIHelper {
    
    static func configureThreeColumnCompositionlalayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize                = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item                    = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets          = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize               = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group                   = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section                 = NSCollectionLayoutSection(group: group)
        section.contentInsets       = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing   = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    static func configureTwoColumnHorizontalCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize                = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item                    = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets          = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize               = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group                   = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section                 = NSCollectionLayoutSection(group: group)
        section.contentInsets       = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing   = 10
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
