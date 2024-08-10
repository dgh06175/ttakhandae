//
//  period.swift
//  ttakhandae
//
//  Created by 이상현 on 8/8/24.
//

import Foundation
import SwiftData

@Model
final class Period
{
    var hour: Int
    
    init(hour: Int) {
        self.hour = hour
    }
}
