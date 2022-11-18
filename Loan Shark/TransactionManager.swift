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
    @Published var personToSearch = ""
    @Published var contactsList: [Person] = []
    var isSearchTermEmpty: Bool { personToSearch == "" }
    
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
        // Bill split unsyncronised, 1 paid, 2 due
        Transaction(name: "Christmas dinner", people: [Person(name: "Woodlands", money: 30, dueDate: "2022-11-29"), Person(name: "Springleaf", money: 40, dueDate: "2022-11-30"), Person(name: "Mayflower", money: 45, dueDate: "2022-11-20", hasPaid: true)], transactionType: .billSplitNoSync),
        // Bill split syncronised, 1 paid 1 due
        Transaction(name: "Gift for Marina Bay", people: [Person(name: "Shenton Way", money: 30, dueDate: "2023-01-11", hasPaid: true), Person(name: "Gardens by the Bay", money: 30, dueDate: "2023-01-11")], transactionType: .billSplitSync),
        // Loan, unpaid
        Transaction(name: "Loan for buying new equipment", people: [Person(name: "Stadium", money: 14.90, dueDate: "2022-11-11")], transactionType: .loan),
        // Paid transaction
        Transaction(name: "Birthday cake", people: [Person(name: "Steven", money: 21, dueDate: "2022-12-14", hasPaid: true)], transactionType: .loan),
        // Transaction due in the very very fat future
        Transaction(name: "Explosives for terrorist attack", people: [Person(name: "Bartley", money: 10, dueDate: "2024-11-11")], transactionType: .loan)
    ]
    
    init() {
        load()
        loadContacts()
        print(getArchiveURL())
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
                            contacts.append(Person(name: contact.givenName + " " + contact.familyName, money: 0, dueDate: "1970-01-01"))
                            #warning("OPTIONALS STILL NEED PARAMETERS WTF")
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
    var filteredContacts: [Person] {
        contactsList.filter { dude in
            dude.name.lowercased().contains(personToSearch.lowercased())
        }
    }
}



