//
//  PRESIRIVE.swift
//  Loan Shark
//
//  Created by Chan Yap Tong on 5/11/22.
//

import Foundation
import SwiftUI
import Contacts

class TransactionManager: ObservableObject {
    @Published var allTransactions: [Transaction] = [] {
        didSet {
            save()
        }
    }
    
    @Published var searchTerm = ""
    @Published var contactsList: [Person] = []
    
    var overdueTransactions: [Transaction] {
        get {
            (searchResults.isEmpty ? allTransactions : searchResults).filter {
                $0.transactionStatus == .overdue
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
                $0.transactionStatus == .dueInOneWeek
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
                $0.transactionStatus == .unpaid
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
                $0.transactionStatus == .paidOff
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
        Transaction(name: "Dinner", people: [Person(name: "Dhoby Ghaut"), Person(name: "Bras Basah")], dueDate: "2023-12-25", isPaid: false, isBillSplitTransaction: true, money: 60.0),
        Transaction(name: "Loan to Jeremy for books", people: [Person(name: "Esplanade")], dueDate: "2022-11-13", isPaid: false, isBillSplitTransaction: false, money: 15.0),
        Transaction(name: "Delivery fees for bomb", people: [Person(name: "Esplanade")], dueDate: "2022-06-12", isPaid: false, isBillSplitTransaction: false, money: 12.0),
        Transaction(name: "Rick and Morty Body Pillow", people: [Person(name: "Promenade")], dueDate: "2022-11-14", isPaid: true, isBillSplitTransaction: false, money: 21.5)
    ]
    
    init() {
        load()
        loadContacts()
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
    
    func loadContacts() {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        var contacts: [Person] = []
                        
                        try store.enumerateContacts(with: request) { (contact, stopPointer) in
                            contacts.append(Person(name: contact.givenName + " " + contact.familyName))
                        }
                        
                        DispatchQueue.main.async {
                            self.contactsList = contacts
                        }
                    } catch let error {
                        print("Failed to enumerate contact", error)
                    }
                }
            } else {
                print("access denied")
            }
        }
    }
}



