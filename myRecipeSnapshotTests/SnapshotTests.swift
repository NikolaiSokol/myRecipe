//
//  SnapshotTests.swift
//  myRecipeSnapshotTests
//
//  Created by Nikolai Sokol on 24.07.2021.
//

import XCTest
import SnapshotTesting
@testable import myRecipe

final class SnapshotTests: XCTestCase {

    func testInFridgeSnapshot() {
        let session = URLSession.shared
        
        let inFridgeController = InFridgeViewController(
            viewModel: InFridgeViewModel(
                imageLoader: ImageLoadingManager(session: session),
                networkManager: InFridgeNetworkManager(session: session)
            ),
            imageLoader: ImageLoadingManager(session: session),
            coreDataStack: CoreDataStack(),
            session: session
        )

        assertSnapshot(matching: inFridgeController, as: .image)
    }

    func testSettingsSnapshot() {
        let settingsController = SettingsViewController(viewModel: SettingsViewModel(), parametersViewFactory: ParametersViewFactory())

        assertSnapshot(matching: settingsController, as: .image)
    }
}
