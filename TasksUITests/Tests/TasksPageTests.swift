//
//  TasksPageTests.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 11.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation
import XCTest

class TasksPageTest: BaseAppSuite {
    
    private lazy var loginView: LoginView = LoginView()
    private lazy var tasksView: TasksViews = TasksViews()
    private lazy var subTasksView: SubTasksView = SubTasksView()
    private lazy var logOutAlert: LogOutAlert = LogOutAlert()
    private lazy var unexpectedErrorAlert: UnexpectedErrorAlert = UnexpectedErrorAlert()

    
    override func setUp() {
        super.setUp()
        if !tasksView.logOutButton().exists {
            loginView.logInToSystem()
            if unexpectedErrorAlert.description().waitForExistence(timeout: 3) {
                unexpectedErrorAlert.tapRetryButton()
            }
            tasksView.logOutButton().waitForElement(timeOut: 3)
        }
    }
    
    
    //MARK: TESTCASES:
    
    
    func testPageHeaderPresence() throws {
        XCTAssertTrue(tasksView.pageHeader().waitForExistence(timeout: 4),
                      "No Page header is presented to a user!")
    }
    
    func testDissmissLogout() throws {
        tasksView
            .openLogOutAlert()
            .dismissLogout()
        
        let isAlertExists = logOutAlert.title().waitForExistence(timeout: 1)
        XCTAssertFalse(isAlertExists, "Logout alert isn't dismissed!")
    }
    
    func testCheckAllTasksArePresent() throws {
        let allTasksFromPage = tasksView.getAllTasksTitles()
        XCTAssertEqual(allTasksFromPage, Tasks.allTasks, "Some required tasks are not shown to a user!")
    }
    
    func testSortAndCompleteTasks() throws {
        tasksView
            .tapSortByNameButton()
            .tapOnCompleteAllButton()
        
        let sortedTasks = tasksView.getAllTasksTitles()
        let allBoxesStatuses = tasksView.getAllCheckBoxesStatuses()
        
        XCTAssertEqual(sortedTasks, Tasks.allTasks.sorted(),
                       "Wrong behavior: sorting mechanism is broken!")
        XCTAssertTrue(allBoxesStatuses.contains(CheckboxStatus.selected),
                       "Wrong behavior: sort button complete tasks!")
    }
    
    func testTaskWithMoreInfoCanBeCompleted() throws {
        let moreInfoPosition = tasksView.getAllTasksWithMoreInfo().randomElement()
        let isTappedTaskCompleted = tasksView
            .tapOnTask(position: moreInfoPosition!)
            .getCheckBoxState(position: moreInfoPosition!)
            .elementsEqual(CheckboxStatus.selected)
        
        XCTAssertTrue(isTappedTaskCompleted,
                      "Wrong behavior after tapping on task with More Info button: task is not completed!")
    }
    
    func testMoreInfoButtonRedirectsToSubtasksView() throws {
        let moreInfoPosition = tasksView.getAllTasksWithMoreInfo().randomElement()
        let taskWithMoreInfoLabel = tasksView.getTask(position: moreInfoPosition!).label
        
        tasksView.tapOnMoreInfoButtonOnTask()
        let screenHeader = tasksView.getPageHeader(header: taskWithMoreInfoLabel)

        XCTAssertEqual(screenHeader, taskWithMoreInfoLabel, "Wrong page header name!")
    }
    
    func testGoBackToAllTasksScreen() throws {
        tasksView
            .tapOnMoreInfoButtonOnTask()
            .tapOnBackToTasksScreenButton()
        
        XCTAssertTrue(tasksView.pageHeader().waitForExistence(timeout: 3), "User isn't returned back to main Tasks screen!")
    }
    
    func testAllSubtasksArePresentForMainTask() throws {
        tasksView.tapOnMoreInfoButtonOnTask()
        if subTasksView.pageHeader(header: "Sleep").waitForExistence(timeout: 3) {
            let subTasks = tasksView.getAllTasksTitles()
            XCTAssertEqual(subTasks, Tasks.subTasks, "Some subtasks are missed!")
        }
    }
    
    func testSortAllTasksOnTheSubtasksPage() throws {
        subTasksView.tapOnMoreInfoButtonOnTask()
            .tapSortByNameButton()
        let sortedTasks = subTasksView.getAllTasksTitles()
        XCTAssertEqual(sortedTasks, Tasks.subTasks.sorted(),
                       "Wrong behavior: sorting mechanism is broken!")
    }
    
    func testLogOutFromSubtasksScreen() throws {
        XCTAssertTrue(subTasksView
            .logOutFromSystem()
            .logInButton().waitForExistence(timeout: 3),
                      "User isn't logged out from subtasks page!")
    }
    
//    
//            //MARK: BUGS WERE FOUND!:
//
    
    func testCheckTasksStatusesAfterCompletionUncompletion() throws {
        var taskCompletionStatuses: Array<String> = []
        
        for taskPosition in 0...tasksView.getAmountOfTasks() {
            tasksView.tapOnTask(position: taskPosition)
            tasksView.tapOnTask(position: taskPosition)
            taskCompletionStatuses.append(tasksView.getCheckBoxState(position: taskPosition))
        }
        XCTAssertFalse(taskCompletionStatuses.contains(CheckboxStatus.selected), """
                       Tasks statuses aren't updated correctly: some tasks still are marked as completed!
                       """)
    }
    
    func testCheckMultipleCompleteAllButton() throws {
        for _ in 1...4 {
            tasksView.tapOnCompleteAllButton()
            let completeAllBoxesStatuses = tasksView.getAllCheckBoxesStatuses()
            XCTAssertTrue(tasksView.cancelAllButton().exists,
                          "The Complete All button isn't change state to Cancel All!")

            tasksView.tapOnCancelAllButton()
            let cancelAllBoxesStatuses = tasksView.getAllCheckBoxesStatuses()
            
            XCTAssertFalse(completeAllBoxesStatuses.contains(CheckboxStatus.unselected),
                           "Some tasks are not completed after Complete All tapping!")
            XCTAssertFalse(cancelAllBoxesStatuses.contains(CheckboxStatus.selected),
                           "Some tasks are not uncompleted after Cancel All tapping!")
        }
    }

    func testMultipleSortingTasksBehavior() throws {
        for _ in 1...4 {
            tasksView.tapSortByNameButton()

            let sortedTasks = tasksView.getAllTasksTitles()
            let allBoxesStatuses = tasksView.getAllCheckBoxesStatuses()

            XCTAssertEqual(sortedTasks, Tasks.allTasks.sorted(),
                           "Wrong behavior: sorting mechanism is broken!")
            XCTAssertFalse(allBoxesStatuses.contains(CheckboxStatus.selected),
                           "Wrong behavior: sort button complete tasks!")
        }
    }
    
    func testCompleteUncompleteAllOnTheSubtasksPage() throws {
        tasksView.tapOnMoreInfoButtonOnTask()
            .tapOnCompleteAllButton()
        var allBoxesStatuses = tasksView.getAllCheckBoxesStatuses()
        XCTAssertTrue(allBoxesStatuses.contains(CheckboxStatus.selected),
                       "Wrong behavior: sort button complete tasks!")
        
        subTasksView.tapOnCancelAllButton()
        allBoxesStatuses = tasksView.getAllCheckBoxesStatuses()
        XCTAssertTrue(allBoxesStatuses.contains(CheckboxStatus.unselected),
                       "Wrong behavior: sort button complete tasks!")
    }
}
