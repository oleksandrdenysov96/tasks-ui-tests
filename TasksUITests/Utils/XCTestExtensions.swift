//
//  XCTestExtensions.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 11.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {
    
    func clearAndEnterText(_ text: String) {
        tap()
        if value != nil {
            guard let stringValue = value as? String else {
                XCTFail("Tried to clear and enter text into a non string value")
                return
            }
            
            let lowerRightCorner = self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
            lowerRightCorner.tap()
            let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined()
            typeText(deleteString)
        }
        typeText(text)
    }
    
    func labelContains(text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        var isContains = false
        if (staticTexts.containing(predicate)).count > 0 {
            isContains = true
        }
        return isContains
    }
    
    @discardableResult
    func waitForElement(timeOut: TimeInterval = 1) -> Bool {
        return waitForExistence(timeout: timeOut)
    }
    
    @discardableResult
    func waitForElementToBecomeHittable(timeOut: TimeInterval = 1) -> Bool {
        return waitForExistence(timeout: timeOut) && isHittable
    }
}

extension XCUIApplication {
    
    func hideKeyboard() {
        let returnButton = buttons["Return"]
        if returnButton.isHittable {
            returnButton.tap()
        }
    }
}
