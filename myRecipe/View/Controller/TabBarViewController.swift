//
//  TabBarViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private lazy var mainViewController: UIViewController = {
        let searchRecipesNetworkManager = SearchRecipesNetworkManager()
        let imageLoader = ImageLoadingManager()
        let homeViewModel = SearchViewModel(searchManager: searchRecipesNetworkManager, imageLoader: imageLoader)
        
        let viewController = SearchViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Search"
        viewControllerItem.image = UIImage(systemName: "text.magnifyingglass")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    private lazy var contactsViewController: UIViewController = {
        let viewController = UIViewController()
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Contacts"
        viewControllerItem.image = UIImage(systemName: "mappin")
        viewController.tabBarItem = viewControllerItem
        return viewController
    }()
    
    private lazy var profileViewController: UIViewController = {
        let viewController = UIViewController()
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Profile"
        viewControllerItem.image = UIImage(systemName: "person")
        viewController.tabBarItem = viewControllerItem
        return viewController
    }()
    
    private lazy var cartViewController: UIViewController = {
        let viewController = UIViewController()
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Cart"
        viewControllerItem.image = UIImage(systemName: "cart")
        viewController.tabBarItem = viewControllerItem
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let controllers = [mainViewController, contactsViewController, profileViewController, cartViewController]
        viewControllers = controllers
        
        tabBar.tintColor = UIColor(named: "buttonTint")
        tabBar.unselectedItemTintColor = .systemGray3
    }
}
