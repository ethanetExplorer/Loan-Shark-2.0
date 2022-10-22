//
//  Debts.swift
//  Loan Shark
//
//  Created by Ethan Lim on 22/10/22.
//

import Foundation

struct Debt: Identifiable {
    var id = UUID()
    var money: Double
    var collector: String
    var debtor: String
    var debtor2: String
    var appliedTags: [Int]
    var daysDueFromNow: Int
}
