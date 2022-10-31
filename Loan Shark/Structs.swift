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
    var people: [String]
    var money: Double
    var appliedTags: [Int]?
    var dueDate: Date
    
    var isOverdue: Bool{
        Date.now > dueDate
    }
    var isDueIn7Days: Bool{
        sevenDayRange.contains(Date.now)
    }
    
    init(name: String, people: [String], money: Double, appliedTags: [Int]? = nil, dueDate: Date) {
        self.name = name
        self.people = people
        self.money = money
        self.appliedTags = appliedTags
        self.dueDate = dueDate
    }
    
    init(name: String, people: [String], money: Double, appliedTags: [Int]? = nil, dueDate: String) {
        self.name = name
        self.people = people
        self.money = money
        self.appliedTags = appliedTags
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.dueDate = dateFormatter.date(from: dueDate)!
    }
}

struct Tag: Identifiable{
    let id = UUID()
    var name: String
    var icon: String
    var color: Color
}

struct Person: Identifiable{
    let id = UUID()
    var name: String
    var creditScore: Int = 0
    var isCreditScoreNegative: Bool{
        creditScore < 0
    }
}
