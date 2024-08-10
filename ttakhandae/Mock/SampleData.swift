//
//  SampleData.swift
//  ttakhandae
//
//  Created by 이상현 on 8/10/24.
//

import SwiftData
import Foundation

@MainActor
let sampleData: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: SmokeRecord.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let modelContext = container.mainContext
        if try modelContext.fetch(FetchDescriptor<SmokeRecord>()).isEmpty {
            MockSmokeData.contents.forEach { container.mainContext.insert($0) }
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

struct MockSmokeData {
    static let contents: [SmokeRecord] = [
        SmokeRecord(date: Date().addingTimeInterval(-70 * 24 * 3600), count: 1), // 70일 전
        SmokeRecord(date: Date().addingTimeInterval(-68 * 24 * 3600), count: 2),  // 68일 전
        SmokeRecord(date: Date().addingTimeInterval(-65 * 24 * 3600), count: 3), // 65일 전
        SmokeRecord(date: Date().addingTimeInterval(-62 * 24 * 3600), count: 4),  // 62일 전
        SmokeRecord(date: Date().addingTimeInterval(-60 * 24 * 3600), count: 3),  // 60일 전
        SmokeRecord(date: Date().addingTimeInterval(-58 * 24 * 3600), count: 2), // 58일 전
        SmokeRecord(date: Date().addingTimeInterval(-55 * 24 * 3600), count: 1),  // 55일 전
        SmokeRecord(date: Date().addingTimeInterval(-53 * 24 * 3600), count: 2), // 53일 전
        SmokeRecord(date: Date().addingTimeInterval(-50 * 24 * 3600), count: 3),  // 50일 전
        SmokeRecord(date: Date().addingTimeInterval(-47 * 24 * 3600), count: 4),  // 47일 전
        SmokeRecord(date: Date().addingTimeInterval(-44 * 24 * 3600), count: 5), // 44일 전
        SmokeRecord(date: Date().addingTimeInterval(-41 * 24 * 3600), count: 2),  // 41일 전
        SmokeRecord(date: Date().addingTimeInterval(-39 * 24 * 3600), count: 1),  // 39일 전
        SmokeRecord(date: Date().addingTimeInterval(-36 * 24 * 3600), count: 2), // 36일 전
        SmokeRecord(date: Date().addingTimeInterval(-34 * 24 * 3600), count: 1), // 34일 전
        SmokeRecord(date: Date().addingTimeInterval(-31 * 24 * 3600), count: 2),  // 31일 전
        SmokeRecord(date: Date().addingTimeInterval(-28 * 24 * 3600), count: 2),  // 28일 전
        SmokeRecord(date: Date().addingTimeInterval(-26 * 24 * 3600), count: 1), // 26일 전
        SmokeRecord(date: Date().addingTimeInterval(-24 * 24 * 3600), count: 1), // 24일 전
        SmokeRecord(date: Date().addingTimeInterval(-21 * 24 * 3600), count: 2),  // 21일 전
        SmokeRecord(date: Date().addingTimeInterval(-18 * 24 * 3600), count: 2),  // 18일 전
        SmokeRecord(date: Date().addingTimeInterval(-15 * 24 * 3600), count: 3), // 15일 전
        SmokeRecord(date: Date().addingTimeInterval(-13 * 24 * 3600), count: 4),  // 13일 전
        SmokeRecord(date: Date().addingTimeInterval(-10 * 24 * 3600), count: 3),  // 10일 전
        SmokeRecord(date: Date().addingTimeInterval(-7 * 24 * 3600), count: 2),  // 7일 전
        SmokeRecord(date: Date().addingTimeInterval(-5 * 24 * 3600), count: 1),   // 5일 전
        SmokeRecord(date: Date().addingTimeInterval(-3 * 24 * 3600), count: 2),  // 3일 전
        SmokeRecord(date: Date().addingTimeInterval(-1 * 24 * 3600), count: 3),   // 1일 전
    ]
}

