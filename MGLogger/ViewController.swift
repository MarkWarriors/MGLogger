//
//  ViewController.swift
//  MGLogger
//
//  Created by Marco Guerrieri on 28/05/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("------ LOG VERBOSE")
        MGL.log("It Log!", level: .error)
        
        print("\n---- CHANGE STYLE, REMOVE LEVEL AND CATEGORIES")
        MGL.setLogStyle(prefix: "Prefix", showLevel: false, showCategories: false)
        MGL.log("It Log!", level: .verbose, category: .notSpecified)
        
        print("\n---- CHANGE STYLE, REMOVE CATEGORIES")
        MGL.setLogStyle(prefix: "Prefix", showLevel: true, showCategories: false)
        MGL.log("It Log!", level: .verbose, category: .notSpecified)
        
        print("\n---- CHANGE STYLE, REMOVE LEVEL")
        MGL.setLogStyle(prefix: "Prefix", showLevel: false, showCategories: true)
        MGL.log("It Log!", level: .verbose, category: .notSpecified)
        
        
        MGL.setLogStyle(prefix: "Prefix", showLevel: true, showCategories: true)
        print("\n\n-------- LOG WITH LEVEL")
        print("---- miniumum level WARNING")
        MGL.showLogWithMinimumLevel(.warning)
        testLogLevels()
        print("---- miniumum level VERBOSE")
        MGL.showLogWithMinimumLevel(.verbose)
        testLogLevels()
        
        
        print("\n\n-------- LOG WITH CATEGORIES")
        print("---- category CUSTOM")
        MGL.showLogWithCategoryIn([.custom])
        testLogCategories()
        print("\n---- category NOTSPECIFIED")
        MGL.showLogWithCategoryIn([.notSpecified])
        testLogCategories()
        print("\n---- category CUSTOM and NOTSPECIFIED")
        MGL.showLogWithCategoryIn([.notSpecified, .custom])
        testLogCategories()
        
        
        print("\n\n-------- LOG WITH LEVEL AND CATEGORIES")
        print("\n---- WARNING with category NOTSPECIFIED")
        MGL.showLogWithMinimumLevel(.warning, inCategories: [.notSpecified])
        testLogLevelsAndCategories()
        
        print("\n---- WARNING with category CUSTOM")
        MGL.showLogWithMinimumLevel(.warning, inCategories: [.custom])
        testLogLevelsAndCategories()
        
        print("\n---- WARNING with category [CUSTOM, NOTSPECIFIED]")
        MGL.showLogWithMinimumLevel(.warning, inCategories: [.notSpecified, .custom])
        testLogLevelsAndCategories()
        
        print("\n---- WARNING with category NOTSPECIFIED")
        MGL.showLogWithMinimumLevel(.verbose, inCategories: [.notSpecified])
        testLogLevelsAndCategories()
        
        print("\n---- WARNING with category CUSTOM")
        MGL.showLogWithMinimumLevel(.verbose, inCategories: [.custom])
        testLogLevelsAndCategories()
        
        print("\n---- WARNING with category [CUSTOM, NOTSPECIFIED]")
        MGL.showLogWithMinimumLevel(.verbose, inCategories: [.notSpecified, .custom])
        testLogLevelsAndCategories()
        
        
        print("\n\n-------- LOG with LEVEL FOR CATEGORIES")
        print("\n---- level: WARNING, category: NOTSPECIFIED | level: VERBOSE, category: CUSTOM")
        MGL.showLogWithSpecificLevelForCategories(
            [.warning : [.notSpecified],
             .verbose : [.custom]])
        testLogLevelsAndCategories()
        print("\n---- level: WARNING, category: NOTSPECIFIED | level: NOLOG, category: CUSTOM")
        MGL.showLogWithSpecificLevelForCategories(
            [.warning : [.notSpecified],
             .noLog : [.custom]])
        testLogLevelsAndCategories()
        print("\n---- level: ERROR, category: [CUSTOM, NOTSPECIFIED]")
        MGL.showLogWithSpecificLevelForCategories(
            [.error : [.notSpecified, .custom]])
        testLogLevelsAndCategories()

        
    }
    
    private func testLogLevels(){
        MGL.log("It Log!1", level: .verbose, categories: [])
        MGL.log("It Log!2", level: .info, categories: [])
        MGL.log("It Log!3", level: .warning, categories: [])
        MGL.log("It Log!4", level: .error, categories: [])
        MGL.log("It Log!5", level: .noLog, categories: [])
    }
    
    private func testLogCategories() {
        MGL.log("It Log!1", level: .verbose, categories: [])
        MGL.log("It Log!2", level: .verbose, categories: [.notSpecified])
        MGL.log("It Log!3", level: .verbose, categories: [.custom])
        MGL.log("It Log!4", level: .verbose, categories: [.interaction])
        MGL.log("It Log!5", level: .verbose, categories: [.notSpecified, .custom, .interaction])
    }
    
    private func testLogLevelsAndCategories(){
        print("-- Not specifing category --")
        testLogLevels()
        
        print("-- Category notSpecified --")
        MGL.log("It Log!1", level: .verbose, category: .notSpecified)
        MGL.log("It Log!2", level: .info, category: .notSpecified)
        MGL.log("It Log!3", level: .warning, category: .notSpecified)
        MGL.log("It Log!4", level: .error, category: .notSpecified)
        MGL.log("It Log!5", level: .noLog, category: .notSpecified)
        
        print("-- Category custom --")
        MGL.log("It Log!1", level: .verbose, category: .custom)
        MGL.log("It Log!2", level: .info, category: .custom)
        MGL.log("It Log!3", level: .warning, category: .custom)
        MGL.log("It Log!4", level: .error, category: .custom)
        MGL.log("It Log!5", level: .noLog, category: .custom)
        
        print("-- Category array with only notSpecified --")
        MGL.log("It Log!1", level: .verbose, categories: [.notSpecified])
        MGL.log("It Log!2", level: .info, categories: [.notSpecified])
        MGL.log("It Log!3", level: .warning, categories: [.notSpecified])
        MGL.log("It Log!4", level: .error, categories: [.notSpecified])
        MGL.log("It Log!5", level: .noLog, categories: [.notSpecified])
        
        print("-- Category array with only custom --")
        MGL.log("It Log!1", level: .verbose, categories: [.custom])
        MGL.log("It Log!2", level: .info, categories: [.custom])
        MGL.log("It Log!3", level: .warning, categories: [.custom])
        MGL.log("It Log!4", level: .error, categories: [.custom])
        MGL.log("It Log!5", level: .noLog, categories: [.custom])
        
        print("-- Category array with only not specified and custom --")
        MGL.log("It Log!1", level: .verbose, categories: [.notSpecified, .custom])
        MGL.log("It Log!2", level: .info, categories: [.notSpecified, .custom])
        MGL.log("It Log!3", level: .warning, categories: [.notSpecified, .custom])
        MGL.log("It Log!4", level: .error, categories: [.notSpecified, .custom])
        MGL.log("It Log!5", level: .noLog, categories: [.notSpecified, .custom])
        
        
    }
    
    
}

