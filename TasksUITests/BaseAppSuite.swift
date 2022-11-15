//
//  TasksUITestsLaunchTests.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 10.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import XCTest

class BaseAppSuite: XCTestCase {
    
    let app = TasksUITests.XCUIAppManager.shared.app
    private lazy var tasksView: TasksViews = TasksViews()

//    override class var runsForEachTargetApplicationUIConfiguration: Bool {
//        true
//    }
    
    override class func setUp() {
        super.setUp()
        TasksUITests.XCUIAppManager.shared.launchApp()
    }

    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = true
        
        if !TasksUITests.XCUIAppManager.shared.isLaunched {
            TasksUITests.XCUIAppManager.shared.launchApp()
        }
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        XCUIAppManager.shared.terminateApp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    
    //MARK: Improve and add XCTIssue
    func attachments() {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
