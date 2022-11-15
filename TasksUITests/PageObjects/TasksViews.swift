//
//  TasksView.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 11.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

class TasksViews: XCUIApplication {

    private lazy var logOutAlert: LogOutAlert = LogOutAlert()
    private lazy var loginPageView: LoginView = LoginView()
    private lazy var subTasksView: SubTasksView = SubTasksView()
    
    func pageHeader(header: String = "Tasks") -> XCUIElement {
        return self.navigationBars[header]
    }
    
    func getPageHeader(header: String) -> String {
        pageHeader(header: header).waitForElement()
        return self.pageHeader(header: header).identifier
    }
    
    func logOutButton() -> XCUIElement {
        return self.buttons["Logout"]
    }
    
    func completeAllButton() -> XCUIElement {
        return self.buttons["Complete All"]
    }
    
    func cancelAllButton() -> XCUIElement {
        return self.buttons.element(matching: XCUIElement.ElementType.button,
                                    identifier: "cancel-tasks-bar-button-item")
    }
    
    func tapOnCompleteAllButton() {
        completeAllButton().waitForElementToBecomeHittable()
        completeAllButton().tap()
    }
    
    func tapOnCancelAllButton() {
        cancelAllButton().waitForElementToBecomeHittable()
        cancelAllButton().tap()
    }
    
    func sortByNameButton() -> XCUIElement {
        return self.buttons["sort-tasks-bar-button-item"]
    }
    
    @discardableResult
    func tapSortByNameButton() -> TasksViews {
        sortByNameButton().tap()
        return self
    }
    
    func getAmountOfTasks() -> Int {
        self.logOutButton().waitForElement(timeOut: 2)
        return self.tables.cells.count - 1
    }

    func getNeededCell(position: Int) -> XCUIElement {
        return self.cells.element(boundBy: position)
    }
    
    @discardableResult
    func tapOnTask(position: Int) -> TasksViews{
        self.getTask(position: position).tap()
        return self
    }
    
    func getTask(position: Int) -> XCUIElement {
        return getNeededCell(position: position).staticTexts.firstMatch
    }
    
    func getCheckBoxState(position: Int) -> String {
        return getNeededCell(position: position).images["cell_image_view"].value as! String
    }
    
    func moreInfoButton(position: Int) -> XCUIElement {
        return self.getNeededCell(position: position).buttons["More Info"]
    }
    
    @discardableResult
    func tapOnMoreInfoButton(position: Int) -> SubTasksView{
        moreInfoButton(position: position).tap()
        return subTasksView
    }
}

class SubTasksView: TasksViews {
    
    func backToTasksButton() -> XCUIElement {
        return self.buttons["Tasks"]
    }
    
    func tapOnBackToTasksScreenButton() {
        backToTasksButton().waitForElementToBecomeHittable()
        backToTasksButton().tap()
    }
    
}

extension TasksViews {
    
    func openLogOutAlert() -> LogOutAlert {
        self.logOutButton().waitForElementToBecomeHittable()
        self.logOutButton().tap()
        return logOutAlert
    }
    
    @discardableResult
    func logOutFromSystem() -> LoginView {
        self.openLogOutAlert().approveLogout()
        return loginPageView
    }
    
    func getAllTaskItems() -> Array<XCUIElement> {
        var allTasks: Array<XCUIElement> = []
        
        for taskPosition in 0...self.getAmountOfTasks() {
            allTasks.append(self.getTask(position: taskPosition))
        }
        return allTasks
    }
    
    func getAllTasksTitles() -> Array<String> {
        var taskTitles: Array<String> = []
        
        for taskPosition in 0...self.getAmountOfTasks() {
            taskTitles.append(self.getTask(position: taskPosition).label)
        }
        return taskTitles
    }
    
    func getAllCheckBoxesStatuses() -> Array<String> {
        var taskCompletionStatuses: Array<String> = []
        
        for taskPosition in 0...self.getAmountOfTasks() {
            taskCompletionStatuses.append(self.getCheckBoxState(position: taskPosition))
        }
        return taskCompletionStatuses
    }
    
    func getAllTasksWithMoreInfo() -> Array<Int> {
        var taskWithMoreInfo: Array<Int> = []
        for taskPosition in 0...self.getAmountOfTasks() {
            if self.moreInfoButton(position: taskPosition).exists {
                taskWithMoreInfo.append(taskPosition)
            }
        }
        return taskWithMoreInfo
    }
    
    @discardableResult
    func tapOnMoreInfoButtonOnTask() -> SubTasksView {
        let moreInfoPosition = self.getAllTasksWithMoreInfo().randomElement()
        self.tapOnMoreInfoButton(position: moreInfoPosition!)
        return subTasksView
    }
}


