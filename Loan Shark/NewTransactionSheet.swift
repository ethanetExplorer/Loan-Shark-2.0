//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du on 3/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    var onCreate: ((Transaction) -> ())
    @State var newTransaction = Transaction(name: "", people: [""], money: 00, dueDate: .now)
    @State var selectedTransactionType = "Loan"
    
    @Environment(\.dismiss) var dismiss
    
    var transactionTypes = ["Bill split", "Loan"]
    
    @State var selectedContact = "James"
    var contacts = ["James", "Jason", "Jerome"]
    
    var decimalNumberFormat: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section{
                        TextField("Title", text: $newTransaction.name)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Picker("Transaction type", selection: $selectedTransactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section {
                        Picker ("Contact", selection: $selectedContact) {
                            ForEach(contacts, id:\.self) {
                                Text($0)
                            }
                        }
                        DatePicker("Due by", selection: $newTransaction.dueDate, in: .now..., displayedComponents: .date)
                        HStack {
                            TextField("Amount", value: $newTransaction.money, formatter: decimalNumberFormat)
                        }
                    }
                }
                
                Button{
                    onCreate(newTransaction)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .disabled(newTransaction.name.isEmpty)
                .padding(.horizontal)
            }
            .navigationTitle("New Transaction")
        }
    }
}

//    struct NewTransactionSheet_Previews: PreviewProvider {
//        static var previews: some View {
//            NewTransactionSheet()
//        }
//    }

