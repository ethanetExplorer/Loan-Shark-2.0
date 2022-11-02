//
//  Debts.swift
//  Loan Shark
//
//  Created by Ethan Lim on 22/10/22.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Codable {
    let id = UUID()
    var name: String
    var people: [String]
    var money: Double
    var appliedTags: [Int]?
    //Should be UUID
    var dueDate: Date
    
    var isOverdue: Bool{
        Date.now > dueDate
    }
    var isDueIn7Days: Bool{
        abs(dueDate.timeIntervalSinceNow) < 604800
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
    var creditScore: Int
    var isCreditScoreNegative: Bool{
        creditScore < 0
    }
}
