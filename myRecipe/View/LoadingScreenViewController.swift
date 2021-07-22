//
//  LoadingScreenViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 29.06.2021.
//

import UIKit

final class LoadingScreenViewController: UIViewController {
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.5)
        view.addSubview(spinner)
        spinner.startAnimating()
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
