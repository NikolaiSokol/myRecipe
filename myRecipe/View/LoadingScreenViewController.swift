//
//  LoadingScreenViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 29.06.2021.
//

import UIKit

final class LoadingScreenViewController: UIViewController {

    private lazy var hatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "hat")
        return imageView
    }()

    private lazy var circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "circle")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.7)

        view.addSubview(hatImageView)
        view.addSubview(circleImageView)

        NSLayoutConstraint.activate([
            hatImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            hatImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            hatImageView.widthAnchor.constraint(equalToConstant: 100),
            hatImageView.heightAnchor.constraint(equalToConstant: 100),

            circleImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            circleImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: 100),
            circleImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        circleImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
}
