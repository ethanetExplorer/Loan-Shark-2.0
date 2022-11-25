//
//  PersonTransactionRow.swift
//  Loan Shark
//
//  Created by Yuhan Du on 20/11/22.
//

import SwiftUI

struct PersonTransactionRow: View {
    
    @ObservedObject var manager: TransactionManager
    var transaction: Transaction
    var transactionIndex: Int {
        manager.allTransactions.firstIndex(where: {
            $0.id == transaction.id
        })!
    }
    var person: Contact
    
    @State var showTransactionDetailSheet = false
    
    var body: some View {
        let transactionPerson: Person = transaction.people.first(where: { $0.contact!.id == person.id })!
        
        Button {
            showTransactionDetailSheet = true
        } label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(transaction.name)
                        .foregroundColor(Color("PrimaryTextColor"))
                    
                    if transaction.transactionStatus == .paidOff {
                        Text("Paid off")
                            .font(.caption)
                            .foregroundColor(Color("SecondaryTextColor"))
                    } else {
                        Text(getTransactionDueDate(for: transaction))
                            .font(.caption)
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                }
                Spacer()
                Text("$" + String(format: "%.2f", transactionPerson.money))
                    .foregroundColor(transaction.transactionStatus == .overdue ? Color("RadRed") : Color("PrimaryTextColor"))
                    .bold()

            }
        }
        .sheet(isPresented: $showTransactionDetailSheet) {
            NavigationView {
                TransactionDetailView(manager: manager, transaction: $manager.allTransactions[transactionIndex])
            }
        }
    }
    
    func getTransactionDueDate(for transaction: Transaction) -> String {
        let dateDiff = Date.now.timeIntervalSince1970 - transaction.dueDate.timeIntervalSince1970
        let daysAgo = abs(Int(dateDiff / (60*60*24)))
        
        if daysAgo == 0 {
            return "Due today"
        } else if dateDiff < 0 {
            return "Due in \(daysAgo) days"
        } else {
            return "Due \(daysAgo) days ago"
        }
    }
}
