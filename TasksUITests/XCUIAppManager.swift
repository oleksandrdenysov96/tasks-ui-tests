//
//  XCUIAppManager.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 10.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

class XCUIAppManager {
    
    static let shared = XCUIAppManager()
    let app = XCUIApplication()
    private(set) var isLaunched = false
    
    private init() {}
    
    func launchApp() {
        app.launch()
        isLaunched = true
    }
    
    func terminateApp() {
        app.terminate()
        isLaunched = false
    }
}
