//
//  MGL.swift
//  MGL
//
//  Created by Marco Guerrieri on 28/05/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//


import Foundation

public class MGL {
    
    public private(set) static var logPrefix : String = "MGLogger"
    public private(set) static var logLevel : LogLevel = .noLog
    public private(set) static var logCategories : [LogCategory] = []
    public private(set) static var logLevelsForCategories : [LogLevel:[LogCategory]] = [:]
    
    public private(set) static var defaultLevel : LogLevel = .verbose
    public private(set) static var defaultCategory : LogCategory = .notSpecified
    public private(set) static var logType : LogType = .noLog
    
    private static var showCategoriesInLog : Bool = true
    private static var showLevelInLog : Bool = true
    
   
    
    public enum LogType: Int16 {
        case noLog = 0
        case all = 1
        case byLevel = 2
        case byCategories = 3
        case byLevelInCategories = 4
        case byLevelsForCategories = 5
    }
    
    public enum LogLevel: Int16 {
        case noLog = 0
        case error = 1
        case warning = 2
        case info = 3
        case verbose = 4
    }
    
    public enum LogCategory: String {
        case notSpecified = "NOTSPECIFIED"
        case custom = "CUSTOM"
        case connection = "CONNECTION"
        case error = "ERROR"
        case warning = "WARNING"
        case info = "INFO"
        case user = "USER"
        case login = "LOGIN"
        case interaction = "INTERACTION"
        case UI = "UI"
        case debug = "DEBUG"
        case timing = "TIMING"
        case thread = "THREAD"
        case queue = "QUEUE"
    }
    
    
    public static func setLogStyle(prefix: String, showLevel: Bool, showCategories: Bool){
        self.logPrefix = prefix
        self.showLevelInLog = showLevel
        self.showCategoriesInLog = showCategories
    }
    
    public static func setLogDefaultLevel(_ level: LogLevel){
        self.defaultLevel = level
    }
    
    public static func setLogDefaultCategory(_ category: LogCategory){
        self.defaultCategory = category
    }
        
    public static func showLogWithCategoryIn(_ categories: [LogCategory]) {
        self.logCategories = categories
        self.logType = .byCategories
    }
    
    public static func showLogWithMinimumLevel(_ level: LogLevel) {
        self.logLevel = level
        self.logType = .byLevel
    }
    
    public static func showLogWithMinimumLevel(_ level: LogLevel, inCategories categories: [LogCategory]) {
        self.logLevel = level
        self.logCategories = categories
        self.logType = .byLevelInCategories
    }
    
    public static func showLogWithSpecificLevelForCategories(_ array: [LogLevel:[LogCategory]]){
        self.logLevelsForCategories = array
        self.logType = .byLevelsForCategories
    }
    
    
    public static func log(_ text: String, level: LogLevel? = defaultLevel, category: LogCategory? = defaultCategory) {
        if level != .noLog {
            self.log(text, level: level ?? defaultLevel, categories: [category ?? defaultCategory])
        }
    }
        
    public static func log(_ text: String, level: LogLevel?, categories: [LogCategory]?) {
        let level = level ?? defaultLevel
        let categories = categories ?? [defaultCategory]
        
        if level != .noLog {
            var log : Bool = false
            
            switch logType {
            case .noLog:
                break
            case .all:
                log = true
                break
            case .byLevel:
                log = level.rawValue <= self.logLevel.rawValue
                break
            case .byCategories:
                log = self.logCategories.contains { (category) -> Bool in
                    return categories.contains(category)
                }
                break
            case .byLevelInCategories:
                log = level.rawValue <= self.logLevel.rawValue && self.logCategories.contains { (category) -> Bool in
                    return categories.contains(category)
                }
                break
            case .byLevelsForCategories:
                for lXc in self.logLevelsForCategories {
                    if level.rawValue <= lXc.key.rawValue && lXc.value.contains { (category) -> Bool in
                        return categories.contains(category)
                        } {
                        log = true
                        break
                    }
                }
            }
            
            if log {
                printLog(text, level: level, categories: categories)
            }
        }
    }
    
    private static func printLog(_ text: String, level: LogLevel, categories: [LogCategory]){
        print("\(self.showLevelInLog || self.showCategoriesInLog ? "\(self.logPrefix) " : "\(self.logPrefix)")\(self.showLevelInLog ? "[\(String(describing: level).uppercased())]": "")\(self.showCategoriesInLog ? "[\(categories.map{String(describing: $0).uppercased()}.joined(separator: "|"))]": ""): \(text)")
    }
    
}
