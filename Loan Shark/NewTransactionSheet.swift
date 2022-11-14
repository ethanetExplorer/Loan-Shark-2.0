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
    
    @State var newTransaction = Transaction(name: "", people: [], totalMoney: 0, transactionType: .unselected)
    @Binding var transactions: [Transaction]
    
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
                        Picker("People", selection: $newTransaction.people){
                            ForEach(contacts){
                                Text($0)
                            }
                        }
                        HStack {
                            Text("Amount of money")
                            TextField("Amount", value: $newTransaction.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                    } else if transactionType == "Bill split" && !isDetailSyncronised {
                        Section {
                            Picker("People", selection: $newTransaction.people){
                                ForEach(contacts){
                                    Text($0)
                                }
                            }
                            HStack {
                                Text("Amount of money")
                                TextField("Amount", value: Person.money, formatter: NumberFormatter())
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.trailing)
                            }
                            DatePicker("Due by", selection: Person.dueDate, in: Date.now..., displayedComponents: .date)
                        }
                    }
                    else if transactionType == "Bill split" && isDetailSyncronised {
                        HStack {
                            Text("Amount of money")
                            TextField("Amount", value: Person.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Section {
                            Picker("People", selection: $newTransaction.people){
                                ForEach(contacts){
                                    Text($0)
                                }
                            }
                            DatePicker("Due by", selection: Person.dueDate, in: Date.now..., displayedComponents: .date)
                        }
                    }
                }
                Spacer()
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

