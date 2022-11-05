//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du on 3/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    @Binding var allTransactions: [Transaction]
    @State var newTransaction = Transaction(name: "", people: [""], money: 00, dueDate: "1970-1-1")
    @State var selectedTransactionType = "Loan"
    var transactionTypes = ["Bill split", "Loan"]
    
    @State var selectedContact = "James"
    var contacts = ["James", "Jason", "Jerome"]
    
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
                        DatePicker("Due by", selection: $newTransaction.dueDate, in: ...newTransaction.dueDate, displayedComponents: .date)
                        //                    HStack {
                        //                        TextField("Amount", text: Double($newTransaction.money))
                    }
                }
                Button{
                    allTransactions.append(newTransaction)
                    //freezes the app
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 50)
                            .cornerRadius(10)
                        Text("Save")
                            .foregroundColor(.white)
                    }
                }
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

