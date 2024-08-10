//
//  ttakhandaeApp.swift
//  ttakhandae
//
//  Created by 이상현 on 8/8/24.
//

import SwiftUI
import SwiftData

@main
struct ttakhandaeApp: App {
    var body: some Scene {
        WindowGroup {
            StartView()
        }
        .modelContainer(for: SmokeRecord.self)
    }
}
