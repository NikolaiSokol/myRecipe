//
//  CuisineType.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 01.03.2023.
//

import Foundation
 
enum CuisineType: String, CaseIterable {
    case `default`
    case african
    case american
    case british
    case cajun
    case caribbean
    case chinese
    case easternEuropean = "eastern european"
    case european
    case french
    case german
    case greek
    case indian
    case irish
    case italian
    case japanese
    case jewish
    case korean
    case latinAmerican = "latin american"
    case mediterranean
    case mexican
    case middleEastern = "middle eastern"
    case nordic
    case southern
    case spanish
    case thai
    case vietnamese
}

extension CuisineType: Localizable {
    // swiftlint:disable:next cyclomatic_complexity
    func localizedString() -> String {
        switch self {
        case .default:
            return String(localized: .select)
            
        case .african:
            return String(localized: .cuisineAfrican)
            
        case .american:
            return String(localized: .cuisineAmerican)
            
        case .british:
            return String(localized: .cuisineBritish)
            
        case .cajun:
            return String(localized: .cuisineCajun)
            
        case .caribbean:
            return String(localized: .cuisineCaribbean)
            
        case .chinese:
            return String(localized: .cuisineChinese)
            
        case .easternEuropean:
            return String(localized: .cuisineEasternEuropean)
            
        case .european:
            return String(localized: .cuisineEuropean)
            
        case .french:
            return String(localized: .cuisineFrench)
            
        case .german:
            return String(localized: .cuisineGerman)
            
        case .greek:
            return String(localized: .cuisineGreek)
            
        case .indian:
            return String(localized: .cuisineIndian)
            
        case .irish:
            return String(localized: .cuisineIrish)
            
        case .italian:
            return String(localized: .cuisineItalian)
            
        case .japanese:
            return String(localized: .cuisineJapanese)
            
        case .jewish:
            return String(localized: .cuisineJewish)
            
        case .korean:
            return String(localized: .cuisineKorean)
            
        case .latinAmerican:
            return String(localized: .cuisineLatinAmerican)
            
        case .mediterranean:
            return String(localized: .cuisineMiddleEastern)
            
        case .mexican:
            return String(localized: .cuisineMexican)
            
        case .middleEastern:
            return String(localized: .cuisineMiddleEastern)
            
        case .nordic:
            return String(localized: .cuisineNordic)
            
        case .southern:
            return String(localized: .cuisineSouthern)
            
        case .spanish:
            return String(localized: .cuisineSpanish)
            
        case .thai:
            return String(localized: .cuisineThai)
            
        case .vietnamese:
            return String(localized: .cuisineVietnamese)
        }
    }
}
