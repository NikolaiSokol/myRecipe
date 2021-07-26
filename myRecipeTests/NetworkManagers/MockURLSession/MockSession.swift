//
//  MockSession.swift
//  myRecipeTests
//
//  Created by Nikolai Sokol on 23.07.2021.
//

import Foundation

final class MockSession {

    static let shared = MockSession()
    private init() {}

    func create(fromJsonFile file: String, andError error: Error?) -> MockURLSession? {
        let data = loadJsonData(file: file)
        return MockURLSession(completionHandler: (data, nil, error))
    }

    private func loadJsonData(file: String) -> Data? {
        if let jsonFilePath = Bundle(for: type(of:  self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }
}
