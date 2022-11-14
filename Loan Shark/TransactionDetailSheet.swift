//
//  TransactionDetailSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du on 12/11/22.
//

import SwiftUI

struct TransactionDetailSheet: View {
    
    @Binding var transaction: Transaction
    
    var onDelete: ((Transaction) -> Void)
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text(transaction.transactionType == .billSplit ? "Bill Split" : "Loan")
                    .padding(.leading, 21)
                List {
                    Section {
                        ForEach(transaction.people, id: \.self) { person in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                VStack{
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(person)
                                                .bold()
                                                .font(.title3)
                                            HStack(alignment: .center, spacing: 0) {
                                                Text(transaction.status == .overdue ? "Due " : "Due in ")
                                                Text(transaction.dueDate, style: .relative)
                                                
                                                if transaction.status == .overdue {
                                                    Text(" ago")
                                                }
                                            }
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Text("$" + String(format: "%.2f", transaction.money))
                                            .foregroundColor(transaction.status == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                            .font(.title2)
                                    }
                                    HStack {
                                        Button {
                                            
                                        } label: {
                                            HStack {
                                                Image(systemName: "message")
                                                Text("Send reminder")
                                            }
                                        }
                                        Button {
                                            
                                        } label: {
                                            HStack {
                                                Image(systemName: "banknote")
                                                Text("Update status")
                                            }
                                        }
                                        //TODO: People structs, import contacts, figure out how to send reminders!!!! 
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(transaction.name)
            .toolbar {
                Button {
                    //Just put new transaction view here but add a new file and modify it such that default values are the ones in the transaction
                } label:  {
                    Image(systemName: "pencil")
                }
                Button {
                    onDelete(transaction)
                    dismiss()
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct TransactionDetailSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionDetailSheet(transaction: $transaction)
//    }
//}