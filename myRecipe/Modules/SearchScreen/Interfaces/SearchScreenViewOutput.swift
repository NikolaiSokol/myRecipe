//
//  SearchScreenViewOutput.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 27.02.2023.
//  
//

import Foundation

protocol SearchScreenViewOutput: AnyObject {
    func didTapCancel()
    func endEditing()
}
