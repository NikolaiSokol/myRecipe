//
//  MainViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 07.06.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fff = SearchRecipesNetworkManager()
        fff.searchRecipesWith(text: "pasta", offset: 0, number: 10) { result in
            switch result {
            case .success(let recipes):
                print(recipes[0].title)
                print(recipes.count)
            case .failure:
                print("error")
            }
        }
    }
}
