//
//  CigaretteRecord.swift
//  ttakhandae
//
//  Created by 이상현 on 8/10/24.
//

import Foundation
import SwiftData

@Model
final class SmokeRecord {
    var date: Date
    var count: Int
    
    init(date: Date, count: Int) {
        self.date = date
        self.count = count
    }
}
