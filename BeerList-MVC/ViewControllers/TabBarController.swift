//
//  TabBarController.swift
//  BeerList-MVC
//
//  Created by Vladyslav Nhuien on 06.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
    }

    private func configureTabBarItems() {
        let listVC = BeerListViewController()
        listVC.tabBarItem = UITabBarItem(title: "Beer List", image: UIImage(systemName: "list.bullet.clipboard"), tag: 0)

        let searchVC = SearchBeerViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search ID", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let randomVC = RandomBeerViewController()
        randomVC.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "dice"), tag: 2)

        let listNavigationVC = UINavigationController(rootViewController: listVC)
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        let randomNavigationVC = UINavigationController(rootViewController: randomVC)
        setViewControllers([listNavigationVC, searchNavigationVC, randomNavigationVC], animated: false)
    }
}
