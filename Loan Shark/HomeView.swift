//
//  HomeView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

enum EditButtons {
    case delete
    case cancel
    case save (Transaction)
}

struct HomeView: View {
    
//    init(transaction: Transaction, dismiss: @escaping (EditButtons) -> Void) {
//        self.dismiss = .dismiss
//        self._transaction = State(initialValue: transaction)
//    }
    
    @StateObject var manager = TransactionManager()
    
    @State var selectedTransactionIndex: Int?
    @State var selectedTransaction: Transaction? = nil
    @State var showTransactionDetailsSheet = false
    @State var showNewTransactionSheet = false
//    var dismiss: (EditButtons) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Outstanding")) {
                    ForEach($manager.overdueTransactions) { transaction1 in
                        Button {
                            showTransactionDetailsSheet = true
                            selectedTransaction = transaction1
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
                                    Text(transaction.people.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", transaction.money))
                                    .foregroundColor(transaction.status == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailView(transaction: transaction1, showBillSplit: transaction.isBillSplitTransaction)
                            transaction.remove(at: transaction.firstIndex(of: selectedTransaction)!)

                        }
                    }
                }
                Section(header: Text("Due in 1 week")) {
                    ForEach($manager.dueIn7DaysTransactions) { transaction1 in
                        Button {
                            showTransactionDetailsSheet = true
                            selectedTransaction = transaction1
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
//                                    Text(transaction.people.joined(separator: ", "))
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", transaction.money))
                                    .foregroundColor(transaction.status == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailView(transaction: transaction1, showBillSplit: transaction.isBillSplitTransaction)
                            transaction.remove(at: transaction.firstIndex(of: selectedTransaction)!)

                        }
                    }
                }
                Section(header: Text("Others")) {
                    ForEach($manager.otherTransactions) { transaction1 in
                        Button {
                            showTransactionDetailsSheet = true
                            selectedTransaction = transaction1
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
                                    Text(transaction.people.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", transaction.money))
                                    .foregroundColor(transaction.status == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet){
                            TransactionDetailView(transaction: transaction1, showBillSplit: transaction.isBillSplitTransaction)
                            transaction.remove(at: transaction.firstIndex(of: selectedTransaction)!)

                        }
                    }
                }
                Section(header: Text("Completed")) {
                    ForEach($manager.completedTransactions) { transaction1 in
                        Button {
                            showTransactionDetailsSheet = true
                            selectedTransaction = transaction1
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
                                    Text(transaction.people.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", transaction.money))
                                    .foregroundColor(transaction.status == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailView(transaction: transaction1, showBillSplit: transaction.isBillSplitTransaction)
                            transaction.remove(at: transaction.firstIndex(of: selectedTransaction)!)
                        }
                    }
                }
            }
            
            .searchable(text: $manager.searchTerm, prompt: Text("Search for a transaction"))
            .navigationTitle("Home")
            .toolbar {
                Button {
                    showNewTransactionSheet = true
                } label: {
                    Image(systemName: "plus.app")
                }
                .sheet(isPresented: $showNewTransactionSheet) {
                    NewTransactionSheet(transactions: $manager.allTransactions)
                }
                
                Menu {
                    Button {
                        print("Filter by time")
                    } label: {
                        Label("Time Due", systemImage: "clock")
                    }
                    Button {
                        print("Filter by amount due")
                    } label: {
                        Label("Amount Due", systemImage: "dollarsign.circle")
                    }
                    Button {
                        print("Filter by date added")
                    } label: {
                        Label("Date Added", systemImage: "calendar")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            //Toolbar
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
