//
//  SearchScreenOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation

protocol SearchScreenOutput: AnyObject {
    func searchScreenDidRequest(event: SearchScreenEvent)
}
