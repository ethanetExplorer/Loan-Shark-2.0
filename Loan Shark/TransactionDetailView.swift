//
//  TransactionDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 15/11/22.
//

import SwiftUI
import UIKit

struct TransactionDetailView: View {
    
    @ObservedObject var manager: TransactionManager
    @Binding var transaction: Transaction
    @State var presentEditTransactionSheet = false
    
    var body: some View {
        VStack(alignment: .leading){
            Group {
                if transaction.transactionType == .loan {
                    Text("Loan")
                } else if transaction.transactionType == .billSplitSync {
                    Text("Bill split, synchronised")
                } else if transaction.transactionType == .billSplitNoSync {
                    Text("Bill split, unsynchronised")
                }
            }
            .font(.title2)
            .padding(.horizontal)
            
            List {
                ForEach($transaction.people) { $person in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                        VStack{
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(person.name ?? "No one Selected")
                                        .bold()
                                        .font(.title3)
                                    HStack(alignment: .center, spacing: 0) {
                                        Text(transaction.transactionStatus == .overdue ? "Due " : "Due in ")
                                        Text(person.dueDate!, style: .relative)
                                        
                                        if transaction.transactionStatus == .overdue {
                                            Text(" ago")
                                        }
                                    }
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("$ \(String(format: "%.2f", person.money!))")
                                    .foregroundColor(transaction.transactionStatus == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                    .font(.title2)
                            }
                            .padding(.top, 10)
                            HStack(alignment: .top){
                                SendMessageButton(person: person)
                                Spacer()
                                Button {
                                    person.hasPaid = true
                                } label: {
                                    HStack {
                                        Image(systemName: "banknote")
                                        Text("Mark as paid")
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                            .foregroundColor(.blue)
                            .padding(10)
                        }
                    }
                }
            }
        .navigationTitle(transaction.name)
        .toolbar {
            Button {
                presentEditTransactionSheet.toggle()
            } label: { Image(systemName: "pencil")}
                .sheet(isPresented: $presentEditTransactionSheet) {
                    NewTransactionSheet(manager: manager, transactions: $manager.allTransactions)
                }
            }
        }
    }
}
