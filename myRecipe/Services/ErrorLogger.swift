//
//  ErrorLogger.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 24.02.2023.
//

import Foundation

final class ErrorLogger {
    static let shared = ErrorLogger()
    
    private init() {}
    
    func log(_ error: Error) {
        guard let decodingError = error as? DecodingError else {
            print(error.localizedDescription)
            return
        }
        
        switch decodingError {
        case let .typeMismatch(type, context):
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        case let .valueNotFound(value, context):
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        case let .keyNotFound(key, context):
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
        case let .dataCorrupted(context):
            print(context)
            
        @unknown default:
            print("Unknown DecodingError")
        }
    }
}
