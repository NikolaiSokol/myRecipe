//
//  TabBarViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let imageLoader = ImageLoadingManager()
    private let coreDataStack = CoreDataStack()

    private lazy var searchViewController: UIViewController = {
        let searchViewModel = SearchViewModel(imageLoader: imageLoader)
        
        let viewController = SearchViewController(viewModel: searchViewModel, imageLoader: imageLoader, coreDataStack: coreDataStack)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Search"
        viewControllerItem.image = UIImage(systemName: "text.magnifyingglass")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    private lazy var savedRecipesViewController: UIViewController = {
        let viewModel = SavedRecipesViewModel(imageLoader: imageLoader, coreDataStack: coreDataStack)
        
        let viewController = SevedRecipesViewController(viewModel: viewModel, imageLoader: imageLoader, coreDataStack: coreDataStack)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Saved"
        viewControllerItem.image = UIImage(systemName: "pin")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let controllers = [searchViewController, savedRecipesViewController]
        viewControllers = controllers
        
        tabBar.tintColor = UIColor(named: "buttonTint")
        tabBar.unselectedItemTintColor = .systemGray3
    }
}
