//
//  PRESIRIVE.swift
//  Loan Shark
//
//  Created by Chan Yap Tong on 5/11/22.
//

import Foundation
import SwiftUI

class TransactionManager: ObservableObject {
    @Published var transaction: [Transaction] = [] {
        didSet {
            save()
        }
    }
    
    let sampleTodos: [Transaction] = []
    
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
        let encodedTodos = try? propertyListEncoder.encode(transaction)
        try? encodedTodos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalTodos: [Transaction]!
        
        if let retrievedTodoData = try? Data(contentsOf: archiveURL),
           let decodedTodos = try? propertyListDecoder.decode([Transaction].self, from: retrievedTodoData) {
            finalTodos = decodedTodos
        } else {
            finalTodos = sampleTodos
        }
        
        transaction = finalTodos
    }
}


