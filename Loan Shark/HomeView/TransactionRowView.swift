//
//  TransactionRowView.swift
//  Loan Shark
//
//  Created by Yuhan Du on 20/11/22.
//

import SwiftUI

struct TransactionRowView: View {
    
    @ObservedObject var manager: TransactionManager
    @Binding var transaction: Transaction
    
    var body: some View {
        NavigationLink {
            TransactionDetailView(manager: manager, transaction: $transaction)
        } label: {
            HStack {
                VStack (alignment: .leading) {
                    Text(transaction.name)
                        .foregroundColor(Color("PrimaryTextColor"))
                    Text(transaction.people.map { $0.name! }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(Color("SecondaryTextColor"))
                }
                Spacer()
                Text("$" + String(format: "%.2f", transaction.totalMoney))
                    .foregroundColor(transaction.transactionStatus == .overdue ? Color("RadRed") : Color("PrimaryTextColor"))
                    .bold()
            }
        }
        .listRowBackground(Color("BGColor"))
    }
}
