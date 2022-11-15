//
//  LogInView.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 10.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

class LoginView: XCUIApplication {
    
    //MARK: Wrong Identifier -> FIXED
    func emailField() -> XCUIElement {
        return self.textFields["login-text-field"]
    }
    
    //MARK: No Identifier -> ADDED
    func passSecureField() -> XCUIElement {
        return self.secureTextFields["password-text-field"]
    }
    
    func logInButton() -> XCUIElement {
        return self.buttons["login-button"]
    }
    
    @discardableResult
    func inputEmail(email: String) -> LoginView {
        emailField().tap()
        emailField().clearAndEnterText(email)
        return self
    }
    
    func inputPassword(password: String) {
        passSecureField().tap()
        passSecureField().clearAndEnterText(password)
    }
    
    func fillAllFields(email: String, password: String) -> LoginView {
        inputEmail(email: email).inputPassword(password: password)
        return self
    }
    
    func tapLoginButton() {
        logInButton().tap()
    }
    
    func logInToSystem(email: String = Credentials.validEmail,
                       password: String = Credentials.validPassword) {
        fillAllFields(email: email, password: password)
            .tapLoginButton()
    }
}

