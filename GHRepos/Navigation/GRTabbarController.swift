//
//  GRTabbarController.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import UIKit


final class GRTabbarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemYellow
        self.viewControllers = [searchNC(), favouritesNC()]
    }
    
    func searchNC() -> UINavigationController {
        let searchVC            = SearchViewController()
        searchVC.title          = "Search"
        searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func favouritesNC() -> UINavigationController {
        let favouritesVC        = FavouritesViewController()
        favouritesVC.title      = "Favourites"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favouritesVC)
    }
    
}
