//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du Du Du Du on 6/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    @StateObject var manager = TransactionManager()
    @State var isDetailSyncronised: Bool = false
    @State var dueDate = Date()
    
    @State var transactionType = ""
    var transactionTypes = ["Select","Loan","Bill split"]
    @Environment(\.dismiss) var dismiss
    
    var decimalNumberFormat: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }
    
    @State var newTransaction = Transaction(name: "Transaction name", people: [Person(name: "Person", money: 69, dueDate: "2023-12-25"), Person(name: "Person 2", money: 96, dueDate: "2023-12-25")], transactionType: .unselected)
    @Binding var transactions: [Transaction]
    
    @State var peopleInvolved = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Transaction details")) {
                        HStack {
                            Text("Title")
                            TextField("Title", text: $newTransaction.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker("Transaction type", selection: $transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        if transactionType == "Bill split" {
                            Toggle(isOn: $isDetailSyncronised){
                                Text("Syncronise details")
                            }
                        }
                    }
                    if transactionType == "Loan" {
                        NavigationLink {
                            PeopleSelectorView()
                        } label: {
                            Text("People")
                        }
                        HStack {
                            Text("Amount of money")
//                            TextField("Amount", value: $newTransaction.money, formatter: NumberFormatter())
//                                .foregroundColor(.gray)
//                                .multilineTextAlignment(.trailing)
                        }
                        DatePicker("Due by", selection: $dueDate, in: Date.now..., displayedComponents: .date)
                    }
                }
                Button {
                    transactions.append(newTransaction)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("New transaction")
        }
    }
}


struct NewTransactionSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionSheet(transactions: .constant([]))
    }
}
