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
    
    @State var newTransaction = Transaction(name: "", people: [Person(name: "", money: 0, dueDate: Date.now)], transactionType: .unselected)
    @Binding var transactions: [Transaction]
    
    @State var numberOfPeople = 0
    @State var addAnotherPerson = false
    
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
                                Text("Syncronise details")}
                        }
                    }
                    if transactionType == "Loan" {
                        NavigationLink {
                            PeopleSelectorView()
                        } label: {
                            Text("Person")
                        }
                        HStack {
                            Text("Amount of money")
                            TextField("Amount", value: $newTransaction.people[0].money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        DatePicker("Due by", selection: $dueDate, in: Date.now..., displayedComponents: .date)
                    }
                    else if transactionType == "Bill split" && !isDetailSyncronised {
                        Section(header: Text("Person \(numberOfPeople + 1)")){
                            NavigationLink {
                                PeopleSelectorView()
                            } label: {
                                Text("Person")
                            }
                            HStack {
                                Text("Total amount")
                                TextField("Amount", value: $newTransaction.people[0].money, formatter: NumberFormatter())
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            DatePicker("Due by", selection: $dueDate, in: Date.now..., displayedComponents: .date)
                        }
                        if addAnotherPerson == true {
                            ForEach(0...numberOfPeople, id: \.self) { person in
                                Section (header: Text("Person 2")){
                                    NavigationLink {
                                        PeopleSelectorView()
                                    } label: {
                                        Text("Person")
                                    }
                                    HStack {
                                        Text("Total amount")
                                        TextField("Amount", value: $newTransaction.people[1].money, formatter: NumberFormatter())
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.trailing)
                                            .keyboardType(.decimalPad)
                                    }
                                    DatePicker("Due by", selection: $dueDate, in: Date.now..., displayedComponents: .date)
                                }
                            }
                        }
                        Button {
                            addAnotherPerson = true
                        } label: {
                            Text("Add")
                        }
                    } else if transactionType == "Bill split" && isDetailSyncronised {
                        NavigationLink {
                            PeopleSelectorView()
                        } label: {
                            Text("People")
                        }
                        HStack {
                            Text("Amount")
                            TextField("Total amount", value: $newTransaction.totalMoney, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
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
