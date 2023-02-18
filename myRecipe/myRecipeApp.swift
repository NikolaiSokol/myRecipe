//
//  myRecipeApp.swift
//  myRecipe
//
//  Created by Nikolai Sokol on 18.02.2023.
//

import SwiftUI

@main
struct myRecipeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
