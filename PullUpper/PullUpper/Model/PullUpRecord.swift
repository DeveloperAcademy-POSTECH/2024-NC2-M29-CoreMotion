//
//  PullUpRecord.swift
//  PullUpper
//
//  Created by hanseoyoung on 6/17/24.
//

import Foundation
import SwiftData

class PullUpRecord {
    var pullUpID = UUID()
    var pullUpDate: Date
    var pullUpCount: Int
    var pullUpGoalCount: Int
    var pullUpMinute: Int
    var pullUpSecond: Int

    init(pullUpCount: Int, pullUpGoalCount: Int, pullUpMinute: Int, pullUpSecond: Int) {
        self.pullUpID = UUID()
        self.pullUpDate = Date()
        self.pullUpCount = pullUpCount
        self.pullUpGoalCount = pullUpGoalCount
        self.pullUpMinute = pullUpMinute
        self.pullUpSecond = pullUpSecond
    }
}
