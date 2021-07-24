//
//  URLSessionDataTask.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
