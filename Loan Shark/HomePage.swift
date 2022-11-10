//
//  HomePage.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

struct HomePage: View {
    
    //    @State var allTags = [
    //        Tag(name: "Loan", icon: "banknote", color: .green),
    //        Tag(name: "Meal", icon: "fork.knife", color: .orange),
    //        Tag(name: "Gifts", icon: "gift", color: .purple),
    //    ]
    @StateObject var manager = TransactionManager()
    
    @State var selectedTransactionIndex: Int?
    
    @State var showTransactionDetailsSheet = false
    @State var showNewTransactionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("OUTSTANDING")) {
                    ForEach($manager.overdueTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction)
                    }
                }
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                    ForEach($manager.dueIn7DaysTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction)
                    }
                }
                
                Section(header: Text("OTHER TRANSACTIONS")) {
                    ForEach($manager.otherTransactions) { $transaction in
                        HomeTransactionView(transaction: $transaction)
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
                    NewTransactionSheet() { transaction in
                        manager.allTransactions.append(transaction)
                    }
                        .presentationDetents([.fraction(6/7), .fraction(1)])
                }
                Menu {
                    Button {
                        
                    } label: {
                        Label("Time Due", systemImage: "clock")
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Amount Due", systemImage: "dollarsign.circle")
                    }
                    
                    Button {
                        
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

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
