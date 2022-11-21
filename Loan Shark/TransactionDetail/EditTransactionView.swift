//
//  EditTransactionView.swift
//  Loan Shark
//
//  Created by Yuhan Du on 21/11/22.
//

import SwiftUI

struct EditTransactionView: View {
    
    @Binding var transaction: Transaction
    var transactionTypes = ["Select", "Loan", "Bill split"]
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section(header: Text("Transaction details")) {
                        HStack {
                            Text("Title")
                            TextField("Title", text: $transaction.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker("Transaction type", selection: $transaction.transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Transaction")
        }
    }
}

