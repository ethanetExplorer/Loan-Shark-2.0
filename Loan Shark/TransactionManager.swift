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
                $0.status == .dueInOneWeek
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
                $0.status == .unpaid
            }
        }
        set {
            for transaction in newValue {
                let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                allTransactions[transactionIndex] = transaction
            }
        }
    }
    
    var completedTransactions: [Transaction] {
        get {
            (searchResults.isEmpty ? allTransactions : searchResults).filter {
                $0.status == .paidOff
            }
        }
        set {
            for transaction in newValue {
                let transactionIndex = allTransactions.firstIndex(where: {$0.id == transaction.id})!
                allTransactions[transactionIndex] = transaction
            }
        }
    }
    
    var searchResults: [Transaction] {
        allTransactions.filter({ transaction in
            transaction.name.lowercased().contains(searchTerm.lowercased())
        })
    }
    
    let sampleTransactions = [
        Transaction(name: "Dinner", people: ["Dhoby Ghaut", "Bras Basah"], dueDate: "2023-12-25", isPaid: false, isBillSplitTransaction: true, money: 60.0),
        Transaction(name: "Loan to Jeremy for books", people: ["Esplanade"], dueDate: "2022-11-13", isPaid: false, isBillSplitTransaction: false, money: 15.0),
        Transaction(name: "Delivery fees for bomb", people: ["Esplanade"], dueDate: "2022-06-12", isPaid: false, isBillSplitTransaction: false, money: 12.0),
        Transaction(name: "Rick and Morty Body Pillow", people: ["Promenade"], dueDate: "2022-11-14", isPaid: true, isBillSplitTransaction: false, money: 21.5)
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



