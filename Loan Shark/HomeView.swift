//
//  HomeView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

struct HomeView: View {

    @StateObject var manager = TransactionManager()
    
    @State var selectedTransactionIndex: Int?
    
    @State var showTransactionDetailSheet = false
    @State var showNewTransactionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("OUTSTANDING")) {
                    ForEach($manager.overdueTransactions) { $transaction in
                        Button {
                            showTransactionDetailSheet = true
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
                    }
                }
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                    ForEach($manager.dueIn7DaysTransactions) { $transaction in
                        Button {
                            showTransactionDetailSheet = true
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
                    }
                    
                    Section(header: Text("OTHER TRANSACTIONS")) {
                        ForEach($manager.otherTransactions) { $transaction in
                            Button {
                                showTransactionDetailSheet = true
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
                        }
                        
                        Section(header: Text("PAID TRANSACTIONS")) {
                            ForEach($manager.completedTransactions) { $transaction in
                                Button {
                                    showTransactionDetailSheet = true
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
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailSheet) {
                            TransactionDetailView(showBillSplit: $0.isBillSplitTransaction)
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
                                NewTransactionSheet()
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
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
