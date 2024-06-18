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

func generateMockPullUpRecords(count: Int) -> [PullUpRecord] {
    var records: [PullUpRecord] = []
    for _ in 0..<count {
        let pullUpCount = Int.random(in: 1...20)
        let pullUpGoalCount = Int.random(in: 1...20)
        let pullUpMinute = Int.random(in: 0...5)
        let pullUpSecond = Int.random(in: 0...59)

        let record = PullUpRecord(pullUpCount: pullUpCount, pullUpGoalCount: pullUpGoalCount, pullUpMinute: pullUpMinute, pullUpSecond: pullUpSecond)
        records.append(record)
    }
    return records
}
