//
//  PersonDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//
import SwiftUI

struct PersonDetailView: View {
    
    func getPersonIndex(array people: [Person]) -> Int? {
        let index = people.firstIndex(where: { $0.name == person.name })
        return index
    }
    
    @ObservedObject var manager: TransactionManager
    @State var showTransactionDetailSheet = false
    var person: Contact
    var userTransactions: [Transaction] {
        manager.allTransactions.filter {
            $0.people.contains(where: { people in
                person.name == people.name
            })
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("ONGOING TRANSACTIONS")) {
                    if !userTransactions.filter { !$0.people[getPersonIndex(array: $0.people)!].hasPaid }.isEmpty {
                        ForEach(userTransactions.filter { !$0.people[getPersonIndex(array: $0.people)!].hasPaid }.sorted { firstTransaction, secondTransaction in
                            firstTransaction.dueDate < secondTransaction.dueDate})
                            { transaction in
                            PersonTransactionRow(manager: manager, transaction: transaction, person: person)
                        }
                    } else {
                        Text("No ongoing transactions.")
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                }
                Section(header: Text("PAST TRANSACTIONS")) {
                    if !userTransactions.filter { $0.people[getPersonIndex(array: $0.people)!].hasPaid }.isEmpty {
                        ForEach(userTransactions.filter { $0.people[getPersonIndex(array: $0.people)!].hasPaid }) { transaction in
                            PersonTransactionRow(manager: manager, transaction: transaction, person: person)
                        }
                    } else {
                        Text("No transaction history.")
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                }
            }
        }
        .navigationTitle(person.name)
    }
}
