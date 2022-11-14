//
//  Loan Shark.swift
//  Loan Shark
//
//  Created by Ethan Lim on 6/11/22.
//

import Foundation
import SwiftUI


enum TransactionTypes: Codable {
    case unselected
    case billSplit
    case loan
}

enum TransactionStatus: Int, Codable {
    case overdue
    case dueInOneWeek
    case unpaid
    case paidOff
}

struct Person: Identifiable, Codable {
    var id = UUID()
    var name: String
    var money: Double?
    var dueDate: Date?
    var selected = false
    var paid = false
}

var contacts = [
    Person(name: "Woodlands"),
    Person(name: "Springleaf"),
    Person(name: "Lentor"),
    Person(name: "Mayflower"),
    Person(name: "Bright Hill"),
    Person(name: "Upper Thomson"),
    Person(name: "Caldecott"),
    Person(name: "Stevens"),
    Person(name: "Napier"),
    Person(name: "Orchard"),
    Person(name: "Great World"),
    Person(name: "Havelock"),
    Person(name: "Outram Park"),
    Person(name: "Maxwell"),
    Person(name: "Shenton Way"),
    Person(name: "Marina Bay")
]

class Transaction: Identifiable, Codable{
    var id = UUID()
    var name: String
    var people: [Person]
    var totalMoney: Double
    var transactionType: TransactionTypes
    
    init(name: String, people: [Person], totalMoney: Double, transactionType: TransactionTypes) {
        self.name = name
        self.people = people
        self.totalMoney = totalMoney
        self.transactionType = transactionType
    }
}

//class Transaction: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var people: [Person]
//    var dueDate: Date = Date.now
//    var isPaid: Bool = false
//
//    var status: TransactionStatus {
//        if isPaid {
//            return .paidOff
//        }
//        else if Date.now > dueDate && !isPaid {
//            return .overdue
//        }
//        else if abs(dueDate.timeIntervalSinceNow) <= 604800 && !isPaid{
//            return .dueInOneWeek
//        }
//        else {
//            return .unpaid
//        }
//    }
//
//    var isBillSplitTransaction: Bool = false
//    var transactionType: TransactionTypes {
//        if isBillSplitTransaction {
//            return .billSplit
//        }
//        else {
//            return .loan
//        }
//    }
//
//    var money: Double = 0
//
//    init(id: UUID = UUID(), name: String, people: [Person], dueDate: String, isPaid: Bool, isBillSplitTransaction: Bool, money: Double) {
//        self.id = id
//        self.name = name
//        self.people = people
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYY-MM-DD"
//
//        self.dueDate = dateFormatter.date(from: dueDate)!
//        self.isPaid = isPaid
//        self.isBillSplitTransaction = isBillSplitTransaction
//        self.money = money
//    }
//}


