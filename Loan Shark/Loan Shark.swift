//
//  Loan Shark.swift
//  Loan Shark
//
//  Created by Ethan Lim on 6/11/22.
//

import Foundation
import SwiftUI


enum TransactionTypes{
    case billSplit
    case loan
}

enum TransactionStatus: Int, Codable {
    case overdue
    case dueInOneWeek
    case unpaid
    case paidOff
}


class Transaction: Identifiable, Codable {
    var id = UUID()
    var name: String
    var people: [String]
    var dueDate: Date = Date.now
    var isPaid: Bool = false
    
    var status: TransactionStatus {
        if isPaid {
            return .paidOff
        }
        else if Date.now > dueDate && !isPaid {
            return .overdue
        }
        else if abs(dueDate.timeIntervalSinceNow) <= 604800 && !isPaid{
            return .dueInOneWeek
        }
        else {
            return .unpaid
        }
    }
    
    var isBillSplitTransaction: Bool = false
    var transactionType: TransactionTypes {
        if isBillSplitTransaction {
            return .billSplit
        }
        else {
            return .loan
        }
    }
    
    var money: Double = 0
    
    init(id: UUID = UUID(), name: String, people: [String], dueDate: String, isPaid: Bool, isBillSplitTransaction: Bool, money: Double) {
        self.id = id
        self.name = name
        self.people = people
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"

        self.dueDate = dateFormatter.date(from: dueDate)!
        self.isPaid = isPaid
        self.isBillSplitTransaction = isBillSplitTransaction
        self.money = money
    }

    init(id: UUID = UUID(), name: String, people: [String], dueDate: Date, isPaid: Bool, isBillSplitTransaction: Bool, money: Double) {
        self.id = id
        self.name = name
        self.people = people
        self.dueDate = dueDate
        self.isPaid = isPaid
        self.isBillSplitTransaction = isBillSplitTransaction
        self.money = money
    }
}


