//
//  PersonDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//
import SwiftUI

struct PersonDetailView: View {
    
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
    @State var transactionIndex: Int?
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("ONGOING TRANSACTIONS")) {
                    
                    ForEach(userTransactions.filter { $0.transactionStatus == .unpaid || $0.transactionStatus == .overdue || $0.transactionStatus == .dueInOneWeek}) { transaction in
                        PersonTransactionRow(manager: manager, transaction: transaction, person: person)
                    }
                }
                Section(header: Text("TRANSACTION HISTORY")) {
                    ForEach(userTransactions.filter { $0.transactionStatus == .paidOff }) { transaction in
                        PersonTransactionRow(manager: manager, transaction: transaction, person: person)
                    }
                }
                
            }
        }
        .navigationTitle(person.name)
    }
}



//struct contactDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailView(person: Person(name: "Jeremy"))
//    }
//}
