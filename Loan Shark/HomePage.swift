//
//  HomePage.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

struct HomePage: View {
    
    @State var allTags = [
        Tag(name: "Loan", icon: "banknote", color: .green),
        Tag(name: "Meal", icon: "fork.knife", color: .orange),
        Tag(name: "Gifts", icon: "gift", color: .purple),
    ]
    
    @State var allTransactions = [
        Transaction(name: "Meal", people: ["Jason"], money: 50, appliedTags: [0], dueDate: "2022-10-15"),
        Transaction(name: "Money loan", people: ["Jerome"], money: 10, appliedTags: [1], dueDate: "2022-11-15"),
        Transaction(name: "MacBook gift", people: ["Jonathan"], money: 2999, appliedTags: [2], dueDate: "2022-11-07")
    ]
    
    @State var selectedTransactionIndex: Int?
    
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    @State var showAddTransactionSheet = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $searchTerm, prompt: Text("Search for a transaction"))
                        .padding(.leading, 30)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                }
                ScrollView(.horizontal) {
                    Spacer()
                        .frame(height: 5)
                    HStack(spacing: 7) {
                        ForEach(allTags) { tag in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.5)
                                    .stroke(tag.color, lineWidth: 1)
                                    .frame(width: 90, height: 25)
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(tag.color)
                                    .padding(.trailing, 66)
                                Image(systemName: tag.icon)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 66)
                                    .font(.system(size: 12))
                                Text(tag.name)
                                    .foregroundColor(tag.color)
                                    .font(.caption)
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .padding(.bottom, 5)
                }
                Section(header: Text("OUTSTANDING")) {
                    ForEach(allTransactions.filter({ $0.isOverdue })) { transaction in
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
                    ForEach(allTransactions.filter({ $0.isDueIn7Days })) { transaction in
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
            .navigationTitle("Home")
            .toolbar {
                Button {
                    showAddTransactionSheet.toggle()
                } label: {
                    Image(systemName: "plus.app")
                }
                .sheet(isPresented: $showAddTransactionSheet) {
                    Text("yuhan is a genius")
                    #warning("EXTREMELY IMPORTANT!!!!!!!!!")
                }
                Button {
                    print("filter search")
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
