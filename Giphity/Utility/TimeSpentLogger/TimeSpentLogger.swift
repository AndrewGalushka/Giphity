//
//  TimeSpendLogger.swift
//  Giphity
//
//  Created by Galushka on 4/24/19.
//  Copyright © 2019 Galushka. All rights reserved.
//

import Foundation

struct TimeSpentLogger {
    private(set) var totalTimeSpent: TimeInterval = 0.0
    private var startDate: Date = Date.init(timeIntervalSince1970: 0)
    private var endDate: Date = Date.init(timeIntervalSinceNow: 0)
    
    mutating func start() {
        reset()
        startDate = Date()
    }
    
    mutating func finish(textBeforeTimeLog: String = "TimeMeter: Total time spent is") {
        endDate = Date()
        self.totalTimeSpent = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        
        print("\(textBeforeTimeLog) \(totalTimeSpent)")
    }
    
    @available(*, deprecated, message: "consider to replace it with finish(textBeforeTimeLog: String)")
    mutating func end(textBeforeTimeLog: String = "TimeMeter: Total time spent is") {
        endDate = Date()
        self.totalTimeSpent = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        
        print("\(textBeforeTimeLog) \(totalTimeSpent)")
    }
    
    private mutating func reset() {
        totalTimeSpent = 0.0
        startDate = Date.init(timeIntervalSince1970: 0)
        endDate = Date.init(timeIntervalSince1970: 0)
    }
}
