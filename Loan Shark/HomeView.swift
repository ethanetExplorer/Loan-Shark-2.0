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
    
    @ObservedObject var manager: TransactionManager
    
    @State var selectedTransactionIndex: Int?
    @State var selectedTransaction: Transaction? = nil
    @State var showTransactionDetailsSheet = false
    @State var showNewTransactionSheet = false
//    var dismiss: (EditButtons) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Outstanding")) {
                    ForEach($manager.overdueTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction) { transactionToDelete in
                            deleteTransaction(transactionToDelete)
                        }
                    }
                }
                Section(header: Text("Due in 1 week")) {
                    ForEach($manager.dueIn7DaysTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction) { transactionToDelete in
                            deleteTransaction(transactionToDelete)
                        }
                    }
                }
                Section(header: Text("Others")) {
                    ForEach($manager.otherTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction) { transactionToDelete in
                            deleteTransaction(transactionToDelete)
                        }
                    }
                }
                Section(header: Text("Completed")) {
                    ForEach($manager.completedTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction) { transactionToDelete in
                            deleteTransaction(transactionToDelete)
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
    
    func deleteTransaction(_ transactionToDelete: Transaction) {
        guard let transactionIndex = manager.allTransactions.firstIndex(where: {
            $0.id == transactionToDelete.id
        }) else { return }
        
        withAnimation {
            manager.allTransactions.remove(at: transactionIndex)
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(manager: .init())
    }
}
