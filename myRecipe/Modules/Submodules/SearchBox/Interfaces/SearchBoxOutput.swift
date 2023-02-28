//
//  SearchBoxOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 23.02.2023.
//  
//

import Foundation

protocol SearchBoxOutput: AnyObject {
    func searchBoxDidRequest(event: SearchBoxEvent)
}
