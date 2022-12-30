//
//  Loan Shark.swift
//  Loan Shark
//
//  Created by Ethan Lim on 6/11/22.
//

import Foundation
import Contacts

enum TransactionTypes: Codable {
    case unselected
    case billSplitSync
    case billSplitNoSync
    case loan
}

enum TransactionStatus: Int, Codable {
    case overdue
    case dueInOneWeek
    case unpaid
    case paidOff
}


struct Contact: Codable, Identifiable {
    var id: String
    
    var name: String {
        let predicate = CNContact.predicateForContacts(withIdentifiers: [id])
        let store = CNContactStore()
        
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
        
        if let contact = try? store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch).first {
            return contact.givenName + " " + contact.familyName
        }
        
        return ""
    }
    
    var phoneNumber: String? {
        let predicate = CNContact.predicateForContacts(withIdentifiers: [id])
        let store = CNContactStore()
        
        let keysToFetch = [CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        if let contact = try? store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch).first {
            let phoneNumber: CNPhoneNumber? = contact.phoneNumbers.first?.value
            return phoneNumber?.stringValue
        }
        
        return nil
    }
    
//    var selectedForTransaction = false
}

struct Person: Identifiable, Codable {
    var id: UUID = UUID()
    
    var contact: Contact?
    var name: String? {
        contact?.name ?? ""
    }
    
    var money: Double?
    var dueDate: Date?
    var hasPaid = false
    
    var personTransactionStatus: TransactionStatus {
        if hasPaid {
            return .paidOff
        } else if dueDate != nil {
            if Date.now > dueDate! && !hasPaid {
                return .overdue
            } else if abs(dueDate!.timeIntervalSinceNow) <= 604800 && !hasPaid{
                return .dueInOneWeek
            } else {
                return .unpaid
            }
        } else {
            return .unpaid
        }
    }
    
    init(contact: Contact? = nil, money: Double, dueDate: String, hasPaid: Bool = false) {
        self.contact = contact
        self.money = money
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"

        self.dueDate = dateFormatter.date(from: dueDate)!
        self.hasPaid = hasPaid
    }
    
    init(contact: Contact? = nil, money: Double, dueDate: Date, hasPaid: Bool = false, selected: Bool = false) {
        self.contact = contact
        self.money = money
        self.dueDate = dueDate
        self.hasPaid = hasPaid
    }
    
}

class Transaction: Identifiable, Codable {
    var id = UUID()
    var name: String
    var people: [Person]
    
    var dueDate: Date {
        let maxDueDate = people.max { firstPerson, secondPerson in
            firstPerson.dueDate! < secondPerson.dueDate!
        }!.dueDate
        
        return maxDueDate!
    }
    
    var isPaid: Bool {
        if people.count == 1 {
            return people[0].hasPaid
        } else {
            return people.allSatisfy { $0.hasPaid }
        }
    }
    var transactionStatus: TransactionStatus {
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
    
    var transactionType: TransactionTypes
    var isNotificationEnabled: Bool
    
    var totalMoney: Double {
        people.reduce(0) { partialResult, person in
            partialResult + (person.money ?? 0)
        }
    }

    init(id: UUID = UUID(), name: String, people: [Person], transactionType: TransactionTypes, isNotificationEnabled: Bool = false) {
        self.id = id
        self.name = name
        self.people = people
        self.transactionType = transactionType
        self.isNotificationEnabled = isNotificationEnabled
    }
}

enum SortingMethods: Hashable {
    case timeDue
    case amount
    case alphabetically
}
