//
//  StartAnimationViewController.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 26.07.2021.
//

import UIKit

final class StartAnimationViewController: UIViewController {

    private lazy var hatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "hat")
        imageView.alpha = 0
        return imageView
    }()

    private lazy var circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "circle")
        imageView.alpha = 0
        return imageView
    }()

    private var imageSize: CGFloat {
        let viewWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let viewHeight = view.safeAreaLayoutGuide.layoutFrame.height

        if viewWidth > viewHeight {
            return viewHeight
        }

        return viewWidth
    }

    var animationsFinished: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        setupViews()
        setupAutoLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }

    private func setupViews() {
        view.addSubview(hatImageView)
        view.addSubview(circleImageView)
    }

    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            hatImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            hatImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            hatImageView.widthAnchor.constraint(equalToConstant: imageSize),
            hatImageView.heightAnchor.constraint(equalToConstant: imageSize),

            circleImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            circleImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: imageSize),
            circleImageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }

    private func startAnimation() {
        UIView.animate(
            withDuration: 0.5,
            animations: { [weak self] in
                self?.circleImageView.alpha = 1
            }, completion: { [weak self] _ in
                self?.animateSpin()
            }
        )
    }

    private func animateSpin() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            options: UIView.AnimationOptions.curveLinear,
            animations: { [weak self] in
                self?.circleImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            },
            completion: nil
        )

        UIView.animate(
            withDuration: 0.8,
            delay: 0.8,
            options: UIView.AnimationOptions.curveLinear,
            animations: { [weak self] in
                self?.circleImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
                self?.hatImageView.alpha = 1
            },
            completion: { [weak self] _ in
                self?.animateFadeOut()
            }
        )
    }

    private func animateFadeOut() {
        UIView.animate(
            withDuration: 1,
            delay: 0.3,
            options: UIView.AnimationOptions.curveLinear,
            animations: { [weak self] in
                self?.circleImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self?.hatImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            },
            completion: nil
        )

        UIView.animate(
            withDuration: 0.7,
            delay: 0.6,
            options: UIView.AnimationOptions.curveLinear,
            animations: { [weak self] in
                self?.circleImageView.alpha = 0
                self?.hatImageView.alpha = 0
            },
            completion: { [weak self] _ in
                self?.animationsFinished?()
            }
        )
    }
}
