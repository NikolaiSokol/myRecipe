//
//  TabBarViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let parametersViewFactory = ParametersViewFactory()
    private let imageLoader = ImageLoadingManager()
    private let coreDataStack = CoreDataStack()

    private lazy var searchViewController: UIViewController = {
        let searchViewModel = SearchViewModel(imageLoader: imageLoader)
        
        let viewController = SearchViewController(viewModel: searchViewModel, parametersViewFactory: parametersViewFactory, imageLoader: imageLoader, coreDataStack: coreDataStack)
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
    
    private lazy var inFridgeViewController: UIViewController = {
        let viewModel = InFridgeViewModel(imageLoader: imageLoader)
        
        let viewController = InFridgeViewController(viewModel: viewModel, imageLoader: imageLoader, coreDataStack: coreDataStack)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "In Fridge"
        viewControllerItem.image = UIImage(systemName: "questionmark.square")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    private lazy var settingsViewController: UIViewController = {
        let viewModel = SettingsViewModel()
        
        let viewController = SettingsViewController(viewModel: viewModel, parametersViewFactory: parametersViewFactory)
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Settings"
        viewControllerItem.image = UIImage(systemName: "gear")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let controllers = [searchViewController, savedRecipesViewController, inFridgeViewController, settingsViewController]
        viewControllers = controllers
        
        tabBar.tintColor = UIColor(named: "accent")
        tabBar.unselectedItemTintColor = .systemGray3
    }
}
