//
//  Ej03_BogdanAlexandru_PotcoavaUITestsLaunchTests.swift
//  Ej03_BogdanAlexandru_PotcoavaUITests
//
//  Created by Alexandru Bogdan Potcoava on 5/2/22.
//

import XCTest

class Ej03_BogdanAlexandru_PotcoavaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
