//
//  ImageLoadingManagerProtocol.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import UIKit

protocol ImageLoadingManagerProtocol {

    typealias ImageCompletion = (Result<UIImage, Error>) -> Void

    func loadImage(imageUrl: String, completion: @escaping ImageCompletion)
}
