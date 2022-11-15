//
//  TasksUITests.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 10.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//
import Foundation
import XCTest

class LoginPageTest: BaseAppSuite {
    
    private lazy var loginView: LoginView = LoginView()
    private lazy var tasksView: TasksViews = TasksViews()
    private lazy var logOutAlert: LogOutAlert = LogOutAlert()
    private lazy var errorAlert: ErrorAlert = ErrorAlert()
    private lazy var unexpectedErrorAlert: UnexpectedErrorAlert = UnexpectedErrorAlert()


    override func setUp() {
        super.setUp()
        if tasksView.logOutButton().exists {
            tasksView.logOutFromSystem()
        }
    }
    
    //MARK: TESTCASES:
    
    func testSuccessLoginLogout() throws {
        loginView.logInToSystem()
        XCTAssertTrue(tasksView.pageHeader().waitForExistence(timeout: 4), "User isn't logged in!")
        
        tasksView.logOutFromSystem()
        XCTAssertTrue(loginView.logInButton().waitForExistence(timeout: 4), "User isn't logged out!")
    }
    

    func testLoginWithoutPassword() throws {
        loginView.inputEmail(email: Credentials.validEmail).tapLoginButton()
        XCTAssertFalse(loginView.logInButton().isEnabled)
    }
    
    func testLoginWithInvalidMails() throws {
        loginView
            .fillAllFields(email: Credentials.invalidEmail, password: Credentials.validPassword)
            .tapLoginButton()
        XCTAssertTrue(errorAlert.title().exists, "No invalid login error while entering email with reserved symbols!")
        
        errorAlert.tapOkButton()
        
        loginView
            .fillAllFields(email: Credentials.noDomenEmail, password: Credentials.validPassword)
            .tapLoginButton()
        XCTAssertTrue(errorAlert.title().exists, "No invalid login error while entering email w/o domen!")
        
        errorAlert.tapOkButton()
        
        loginView
            .fillAllFields(email: " ", password: Credentials.validPassword)
            .tapLoginButton()
        XCTAssertTrue(errorAlert.title().exists, "No invalid login error while entering email w/o domen!")
    }
    
                //MARK: BUGS WERE FOUND!:
    
    func testKeyboardIsHidden() throws {
        loginView
            .fillAllFields(email: Credentials.validEmail, password: Credentials.validPassword)
            .hideKeyboard()
        XCTAssertFalse(loginView.buttons["Return"].exists, "Keyboard isn't hidden!")
    }
    
    func testMinimumPasswordLength() throws {
        loginView
            .fillAllFields(email: Credentials.validEmail, password: Credentials.shortPassword)
            .tapLoginButton()
        XCTAssertTrue(errorAlert.title().exists, "Mimimum length password limitation isn't working!")
    }
    
    func testMaximumPasswordLength() throws {        
        loginView
            .fillAllFields(email: Credentials.validEmail, password: Credentials.longPassword)
            .tapLoginButton()
        XCTAssertTrue(errorAlert.title().exists, "Maximum length password limitation isn't working!")
    }
    
    func testMultipleLoginToSystem() throws {
        for _ in 1...3  {
            loginView.logInToSystem()
            XCTAssertTrue(tasksView.pageHeader().waitForExistence(timeout: 4), "User isn't logged in! Unexpected error!")
            
            if unexpectedErrorAlert.description().exists {
                unexpectedErrorAlert.tapRetryButton()
                XCTAssertTrue(tasksView.pageHeader().waitForExistence(timeout: 4), "Unable to re-login after failure!")
                break
            }
            tasksView.logOutFromSystem()
        }
    }
}
