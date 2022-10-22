//
//  Debt.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
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
