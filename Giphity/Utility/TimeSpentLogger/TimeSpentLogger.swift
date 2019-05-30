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
    private var endDate: Date = Date.init(timeIntervalSince1970: 0)
    
    mutating func start() {
        reset()
        startDate = Date()
    }
    
    mutating func finish(textBeforeTimeLog: String = "TimeSpentLogger: Total time spent is") {
        endDate = Date()
        self.totalTimeSpent = endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970
        
        #if DEBUG
        print("\(textBeforeTimeLog) \(totalTimeSpent)")
        #endif
    }
    
    private mutating func reset() {
        totalTimeSpent = 0.0
        startDate = Date.init(timeIntervalSince1970: 0)
        endDate = Date.init(timeIntervalSince1970: 0)
    }
}
