//
//  TabBarViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 10.06.2021.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private let session: URLSession = .shared
    private let parametersViewFactory = ParametersViewFactory()
    private lazy var imageLoader = ImageLoadingManager(session: session)
    private let coreDataStack = CoreDataStack()

    private lazy var searchViewController: UIViewController = {
        let networkManager = SearchRecipesNetworkManager(session: session)
        let searchViewModel = SearchViewModel(networkManager: networkManager, imageLoader: imageLoader)
        
        let viewController = SearchViewController(
            viewModel: searchViewModel,
            parametersViewFactory: parametersViewFactory,
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
            session: session
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Search"
        viewControllerItem.image = UIImage(systemName: "text.magnifyingglass")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    private lazy var savedRecipesViewController: UIViewController = {
        let viewModel = SavedRecipesViewModel(imageLoader: imageLoader, coreDataStack: coreDataStack)
        
        let viewController = SevedRecipesViewController(
            viewModel: viewModel,
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
            session: session
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        let viewControllerItem = UITabBarItem()
        viewControllerItem.title = "Saved"
        viewControllerItem.image = UIImage(systemName: "pin")
        viewController.tabBarItem = viewControllerItem
        return navigationController
    }()
    
    private lazy var inFridgeViewController: UIViewController = {
        let networkManager = InFridgeNetworkManager(session: session)
        let viewModel = InFridgeViewModel(imageLoader: imageLoader, networkManager: networkManager)
        
        let viewController = InFridgeViewController(
            viewModel: viewModel,
            imageLoader: imageLoader,
            coreDataStack: coreDataStack,
            session: session
        )
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
        addStartAnimationController()
        setupTabBar()
    }

    private func addStartAnimationController() {
        let controller = StartAnimationViewController()

        addChild(controller)
        controller.view.frame = view.frame
        view.addSubview(controller.view)
        controller.didMove(toParent: self)

        controller.animationsFinished = {
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
    
    private func setupTabBar() {
        let controllers = [searchViewController, savedRecipesViewController, inFridgeViewController, settingsViewController]
        viewControllers = controllers
        
        tabBar.tintColor = UIColor(named: "accent")
        tabBar.unselectedItemTintColor = .systemGray3
    }
}
