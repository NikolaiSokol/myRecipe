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
        let homeViewModel = HomeViewModel(searchManager: searchRecipesNetworkManager, imageLoader: imageLoader)
        
        let viewController = HomeViewController(viewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Main"
        viewControllerItem.image = UIImage(systemName: "house")
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
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let controllers = [mainViewController, contactsViewController, profileViewController, cartViewController]
        viewControllers = controllers
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .red
        tabBar.unselectedItemTintColor = .gray
    }
}
