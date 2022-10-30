//
//  Debts.swift
//  Loan Shark
//
//  Created by Ethan Lim on 22/10/22.
//

import Foundation
import SwiftUI



struct Transaction: Identifiable {
    var id = UUID()
    var name: String
    var people: String
    var money: Double
    var appliedTags: [Int]?
    var daysDueFromNow: Int
    var isOverdue: Bool{
        daysDueFromNow <= 0
    }
    var isDuIn7Days: Bool{
        daysDueFromNow <= 7
    }
}

struct Tag: Identifiable{
    var id = UUID()
    var name: String
    var icon: String
    var colour: Color
}

struct Person: Identifiable{
    var id = UUID()
    var name: String
    var creditScore: Int = 0
    var isCreditScoreNegative: Bool{
        creditScore < 0
    }
}
