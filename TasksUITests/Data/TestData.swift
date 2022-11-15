//
//  TestData.swift
//  TasksUITests
//
//  Created by oleksandr denysov on 11.11.2022.
//  Copyright © 2022 Cultured Code. All rights reserved.
//

import Foundation

class Credentials {
    
    static var validEmail = "valid.email@gmail.com"
    static var invalidEmail = "!invalid?@gmail.com"
    static var noDomenEmail = "email"
    
    static var validPassword = "123qwe#$!>?"
    static var longPassword = "longPassword\(pow(_: 10000, _: 9))"
    static var shortPassword = "s"
    
}

class CheckboxStatus {
    
    static var selected = "Selected"
    static var unselected = "Not selected"
}

class Tasks {
    
    static var allTasks: Array = ["Buy milk", "Pay rent", "Change tires", "Sleep", "Dance"]
    static var subTasks = ["Find a bed", "Lie down", "Close eyes", "Wait"]
}
