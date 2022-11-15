//
//  Alerts.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 11.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

class BaseAlert: XCUIApplication {
    
    func title(text: String) -> XCUIElement {
        return self.staticTexts[text]
    }
    
    func description(text: String) -> XCUIElement {
        return self.staticTexts[text]
    }
    
    func tapConfirmActionButton(name: String) {
        self.scrollViews.buttons[name].tap()
    }
    
    func tapDismissButton(name: String = "Cancel") {
        self.scrollViews.buttons[name].tap()
    }
}

class ErrorAlert: BaseAlert {
    
    func title() -> XCUIElement {
        return self.title(text: "Error")
    }
    
    func tapOkButton() {
        self.tapConfirmActionButton(name: "Ok")
    }
}

class UnexpectedErrorAlert: BaseAlert {
    
    func title() -> XCUIElement {
        return self.title(text: "Error")
    }
    
    func description() -> XCUIElement {
        return self.description(text: "Unexpected login error occured")
    }
    
    func tapRetryButton() {
        self.tapConfirmActionButton(name: "Retry")
    }
}

class LogOutAlert: BaseAlert {
    
    func title() -> XCUIElement {
        return self.title(text: "Do you really want to logout?")
    }
    
    func approveLogout() {
        self.tapConfirmActionButton(name: "Logout")
    }
    
    func dismissLogout() {
        self.tapDismissButton()
    }
}
