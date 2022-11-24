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
//    var personIndex: Int? {
//        for transaction in userTransactions {
//            transaction.people.firstIndex(where: $0.name == person.name)
//        }
//    }
//}

var body: some View {
    NavigationView{
        List {
            Section(header: Text("ONGOING TRANSACTIONS")) {
                
                ForEach(userTransactions.filter { !$0.people[getPersonIndex(array: $0.people)!].hasPaid }) { transaction in
                    PersonTransactionRow(manager: manager, transaction: transaction, person: person)
                }
            }
            Section(header: Text("TRANSACTION HISTORY")) {
                ForEach(userTransactions.filter { $0.people[getPersonIndex(array: $0.people)!].hasPaid }) { transaction in
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
