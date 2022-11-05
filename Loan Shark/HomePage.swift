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
    
    @State var allTransactions = [
        Transaction(name: "Meal", people: ["Jason", "Jackson"], money: 500, dueDate: "2022-12-25"),//, appliedTags: 0),
        Transaction(name: "Money loan", people: ["Jerome"], money: 10, dueDate: "2022-11-7"),//, appliedTags: 1),
        Transaction(name: "MacBook gift", people: ["Jonathan"], money: 2999, dueDate: "2022-10-25")//, appliedTags: 2)
    ]
    
    @State var searchResults: [Transaction] = []
    
    @State var selectedTransactionIndex: Int?
    
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    @State var showNewTransactionSheet = false
    
    var body: some View {
        
        let transactions = (searchResults.isEmpty ? allTransactions : searchResults)
        
        NavigationView {
            List {
                //                HStack {
                //                    ScrollView(.horizontal) {
                //                        Spacer()
                //                            .frame(height: 5)
                //                        HStack(spacing: 7) {
                //                            ForEach(allTags) { tag in
                //                                ZStack {
                //                                    RoundedRectangle(cornerRadius: 12.5)
                //                                        .stroke(tag.color, lineWidth: 1)
                //                                        .frame(width: 90, height: 25)
                //                                    Circle()
                //                                        .frame(width: 20, height: 20)
                //                                        .foregroundColor(tag.color)
                //                                        .padding(.trailing, 66)
                //                                    Image(systemName: tag.icon)
                //                                        .foregroundColor(.white)
                //                                        .padding(.trailing, 66)
                //                                        .font(.system(size: 12))
                //                                    Text(tag.name)
                //                                        .foregroundColor(tag.color)
                //                                        .font(.caption)
                //                                        .padding(.leading, 20)
                //                                }
                //                            }
                //                        }
                //                        .padding(.bottom, 5)
                //                    }
                //
                //                    Button {
                //
                //                    } label: {
                //                        Image(systemName: "plus.circle")
                //                    }
                //                }
                //                .buttonStyle(.plain)
                Section(header: Text("OUTSTANDING")) {
                    ForEach(transactions.filter({ $0.isOverdue })) { transaction in
                        let bindingTransaction = Binding {
                            transaction
                        } set: { newTransaction in
                            let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                            allTransactions[transactionIndex] = newTransaction
                        }
                        
                        HomeTransactionView(transaction: bindingTransaction)
                    }
                }
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                    ForEach(transactions.filter({ $0.isDueIn7Days })) { transaction in
                        let bindingTransaction = Binding {
                            transaction
                        } set: { newTransaction in
                            let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                            allTransactions[transactionIndex] = newTransaction
                        }
                        
                        HomeTransactionView(transaction: bindingTransaction)
                    }
                }
                
                Section(header: Text("OTHER TRANSACTIONS")) {
                    ForEach(transactions.filter({ !$0.isDueIn7Days && !$0.isOverdue })) { transaction in
                        let bindingTransaction = Binding {
                            transaction
                        } set: { newTransaction in
                            let transactionIndex = allTransactions.firstIndex(where: { $0.id == transaction.id })!
                            allTransactions[transactionIndex] = newTransaction
                        }
                        
                        HomeTransactionView(transaction: bindingTransaction)
                    }
                }
                
            }
            .searchable(text: $searchTerm, prompt: Text("Search for a transaction"))
            .onChange(of: searchTerm) { _ in
                searchResults = allTransactions.filter({ transaction in
                    transaction.name.lowercased().contains(searchTerm.lowercased())
                })
            }
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
