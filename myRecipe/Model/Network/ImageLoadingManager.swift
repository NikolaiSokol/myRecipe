//
//  ImageLoadingManager.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 15.06.2021.
//

import UIKit

struct ImageLoadingManager {
    
    func loadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(URLError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
