//
//  EatOutToHelpOutScreeshots.swift
//  EatOutToHelpOutScreeshots
//
//  Created by Cedric on 09/08/2020.
//  Copyright © 2020 cedric06nice. All rights reserved.
//

import XCTest

class EatOutToHelpOutScreeshots: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app, waitForAnimations: false)
        var launchArguments: [AnyHashable] = []
        launchArguments.append("-AppleInterfaceStyle")
        launchArguments.append("Light")
        app.launchArguments = launchArguments as! [String]
        app.launch()
        
        if ProcessInfo().arguments.contains("SKIP_ANIMATIONS") {
            UIView.setAnimationsEnabled(false)
        }
        
        snapshot("0-Main-screen")
        
        app.textFields["£"].tap()
        app.buttons["3"].tap()
        app.buttons["8"].tap()
        app.buttons["."].tap()
        app.buttons["4"].tap()
        app.buttons["0"].tap()
        
        snapshot("1-Calculator")
        
        app.staticTexts["="].tap()
        
        snapshot("2-Screen-with-result")
        
        app.textFields["%"].tap()
        app.keys["2"].tap()
        app.keys["0"].tap()
        app.staticTexts["Calculate"].tap()
        
        snapshot("3-Screen-with-percentage")
        
    }
    
    func testExampleDarkMode() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launchArguments.append("UITestingDarkModeEnabled")
        app.launch()
        
        if ProcessInfo().arguments.contains("SKIP_ANIMATIONS") {
            UIView.setAnimationsEnabled(false)
        }
                
        app.textFields["£"].tap()
        app.buttons["3"].tap()
        app.buttons["8"].tap()
        app.buttons["."].tap()
        app.buttons["4"].tap()
        app.buttons["0"].tap()
        
        snapshot("4-Dark-Mode-Calculator")
        
        app.staticTexts["="].tap()
        
        snapshot("5-Dark-Mode-with-Result")
    }
    
    /*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    */
}
