//
//  Debts.swift
//  Loan Shark
//
//  Created by Ethan Lim on 22/10/22.
//

import Foundation
import SwiftUI



struct Debt: Identifiable {
    var id = UUID()
    var money: Double
    var name: String
    var debtors: [String]
    var appliedTags: [Int]
    var daysDueFromNow: Int
}

struct Tag: Identifiable{
    var id = UUID()
    var name: String
    var icon: String
    var colour: Color
}

struct Contact: Identifiable{
    var id = UUID()
    var name: String
    var creditScore: Int = 0
    var isNegative: Bool?
}
