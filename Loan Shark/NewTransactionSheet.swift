//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du on 3/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    @State var newTransaction = Transaction(name: "", people: [""], money: 00, dueDate: "1970-1-1")
    @State var selectedTransactionType = "Loan"
    var transactionTypes = ["Bill split", "Loan"]
    
    @State var selectedContact = "James"
    var contacts = ["James", "Jason", "Jerome"]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("New Transaction")){
                    HStack {
                        TextField("Title", text: $newTransaction.name)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                    }
                    HStack {
                        Picker("Transaction type", selection: $selectedTransactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                Section {
                    HStack{
                        Picker ("Contact", selection: $selectedContact) {
                            ForEach(contacts, id:\.self) {
                                Text($0)
                            }
                        }
                    }
                    DatePicker("Due by", selection: $newTransaction.dueDate, in: ...newTransaction.dueDate, displayedComponents: .date)
                    //                    HStack {
                    //                        TextField("Amount", text: Double($newTransaction.money))
                }
            }
        }
        .navigationTitle("New Transaction")
    }
}

//    struct NewTransactionSheet_Previews: PreviewProvider {
//        static var previews: some View {
//            NewTransactionSheet()
//        }
//    }

