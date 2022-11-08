//
//  PRESIRIVE.swift
//  Loan Shark
//
//  Created by Chan Yap Tong on 5/11/22.
//

import Foundation
import SwiftUI

class TransactionManager: ObservableObject {
    @Published var allTransactions: [Transaction] = [] {
        didSet {
            save()
        }
    }
    
    @Published var searchTerm = ""
    
    var overdueTransactions: [Transaction] {
        get {
            (searchResults.isEmpty ? allTransactions : searchResults).filter {
                $0.status == .overdue
            }
        }
        set {
            for transaction in newValue {
                let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                allTransactions[transactionIndex] = transaction
            }
        }
    }
    
    var dueIn7DaysTransactions: [Transaction] {
        get {
            (searchResults.isEmpty ? allTransactions : searchResults).filter {
                $0.status == .dueIn7Days
            }
        }
        set {
            for transaction in newValue {
                let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                allTransactions[transactionIndex] = transaction
            }
        }
    }
    
    var otherTransactions: [Transaction] {
        get {
            (searchResults.isEmpty ? allTransactions : searchResults).filter {
                $0.status == .normal
            }
        }
        set {
            for transaction in newValue {
                let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                allTransactions[transactionIndex] = transaction
            }
        }
    }
    
    var searchResults: [Transaction] {
        allTransactions.filter({ transaction in
            transaction.name.lowercased().contains(searchTerm.lowercased())
        })
    }
    
    let sampleTransactions: [Transaction] = [
        Transaction(name: "Meal", people: ["Jason", "Jackson"], money: 500, dueDate: "2022-12-25"),//, appliedTags: 0),
        Transaction(name: "Money loan", people: ["Jerome"], money: 10, dueDate: "2022-11-7"),//, appliedTags: 1),
        Transaction(name: "MacBook gift", people: ["Jonathan"], money: 2999, dueDate: "2022-10-25")//, appliedTags: 2)
    ]
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "transactions.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedTransactions = try? propertyListEncoder.encode(allTransactions)
        try? encodedTransactions?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalTransactions: [Transaction]!
        
        if let retrievedTransactionsData = try? Data(contentsOf: archiveURL),
           let decodedTransactions = try? propertyListDecoder.decode([Transaction].self, from: retrievedTransactionsData) {
            finalTransactions = decodedTransactions
        } else {
            finalTransactions = sampleTransactions
        }
        
        allTransactions = finalTransactions
    }
}


