//
//  Debts.swift
//  Loan Shark
//
//  Created by Ethan Lim on 22/10/22.
//

import Foundation
import SwiftUI

let sevenDayRange = Date.now...Date.now.addingTimeInterval(604800)

struct Transaction: Identifiable {
    let id = UUID()
    var name: String
    var people: String
    var money: Double
    var appliedTags: [Int]?
    var dueDate: Date
    
    var isOverdue: Bool{
        Date.now > dueDate
    }
    var isDueIn7Days: Bool{
        sevenDayRange.contains(Date.now)
    }
}

struct Tag: Identifiable{
    let id = UUID()
    var name: String
    var icon: String
    var colour: Color
}

struct Person: Identifiable{
    let id = UUID()
    var name: String
    var creditScore: Int = 0
    var isCreditScoreNegative: Bool{
        creditScore < 0
    }
}
