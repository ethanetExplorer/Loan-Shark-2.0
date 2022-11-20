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
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("ONGOING TRANSACTIONS")) {
                    
                    ForEach(userTransactions.filter { $0.transactionStatus == .unpaid || $0.transactionStatus == .overdue || $0.transactionStatus == .dueInOneWeek}) { transaction in
                        
                        let transactionPerson: Person = transaction.people.first(where: { $0.contact!.id == person.id })!
                        
                        Button {
                            showTransactionDetailSheet = true
                        } label: {
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                    Text(getTransactionDueDate(for: transaction))
                                        .font(.caption)
                                }
                                .foregroundColor(.primary)
                                Spacer()
                                
                                Text("\(decimalNumberFormat.string(for: transactionPerson.money ?? 0)!)")
                                    .foregroundColor(.secondary)
                                    .font(.title2)
                            }
                        }
                        
                    }
                }
                Section(header: Text("TRANSACTION HISTORY")) {
                    ForEach(userTransactions.filter { $0.transactionStatus == .paidOff }) { transaction in
                        Button {
                            showTransactionDetailSheet = true
                        } label: {
                            HStack{
                                VStack{
                                    Text(transaction.name)
                                    Text("Due in \(getTransactionDueDate(for: transaction)) days")
                                }
                                Spacer()
                                Text("\(decimalNumberFormat.string(for: transaction.totalMoney)!)")
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.title2)
                            }
                        }
                    }
                }
                
            }
        }
        .navigationTitle(person.name)
    }
    
    func getTransactionDueDate(for transaction: Transaction) -> String {
        let dateDiff = Date.now.timeIntervalSince1970 - transaction.dueDate.timeIntervalSince1970
        let daysAgo = abs(Int(dateDiff / (60*60*24)))
        
        if daysAgo == 0 {
            return "Due today"
        } else if dateDiff > 0 {
            return "Due in \(daysAgo) days"
        } else {
            return "Due \(daysAgo) days ago"
        }
    }
}



//struct contactDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonDetailView(person: Person(name: "Jeremy"))
//    }
//}
