//
//  HomePage.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

struct HomePage: View {
    
    @State var allTags = [
        Tag(name: "Loan", icon: "banknote", colour: .green),
        Tag(name: "Meal", icon: "fork.knife", colour: .orange),
        Tag(name: "Gifts", icon: "gift", colour: .purple),
    ]
    
    @State var allTransactions = [
        Transaction(name: "Meal", people: "Jason", money: 50, appliedTags: [0]),
        Transaction(name: "Money loan", people: "Jerome", money: 10, appliedTags: [1]),
        Transaction(name: "MacBook gift", people: "Jonathan", money: 2999, appliedTags: [2])
    ]
    
    //    @Binding var bindingTransactions: Transaction
    
    var body: some View {
        NavigationView {
            List($allTransactions){ $transaction in
                NavigationLink{
                    TransactionDetailView(transaction: $transaction)
                }label: {
                    HStack{
                        VStack(alignment: .leading){
                            Text(transaction.name)
                            Text(transaction.people)
                                .font(.caption)
                            
                        }
                        Spacer()
                        Text("$"+String(transaction.money))
                    }
                }
                .navigationTitle("Transactions")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
