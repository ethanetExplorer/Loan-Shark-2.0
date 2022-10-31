//
//  HomePage.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//

import SwiftUI

struct HomePage: View {
    
    @State var allTags = [
        Tag(name: "Loan", icon: "banknote", colour: .green),
        Tag(name: "Meal", icon: "fork.knife", colour: .orange),
        Tag(name: "Gifts", icon: "gift", colour: .purple),
    ]
    
    @State var allTransactions = [
        Transaction(name: "Meal", people: ["Jason"], money: 50, appliedTags: [0], dueDate: "2022-10-15"),
        Transaction(name: "Money loan", people: ["Jerome"], money: 10, appliedTags: [1], dueDate: "2022-11-15"),
        Transaction(name: "MacBook gift", people: ["Jonathan"], money: 2999, appliedTags: [2], dueDate: "2022-11-07")
    ]
    
    @State var transactionsDueInAWeek: [Transaction] = []
    @State var transactionsOutstanding: [Transaction] = []
    
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    @State var showAddTransactionSheet = false
    
    init() {
        for transaction in allTransactions {
            if transaction.isDueIn7Days{
                transactionsDueInAWeek.append(transaction)
            } else if transaction.isOverdue {
                transactionsOutstanding.append(transaction)
            }
        }
    }
    
//    @Binding var bindingTransactions: Transaction
    
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
                                    .stroke(tag.colour, lineWidth: 1)
                                    .frame(width: 90, height: 25)
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(tag.colour)
                                    .padding(.trailing, 66)
                                Image(systemName: tag.icon)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 66)
                                    .font(.system(size: 12))
                                Text(tag.name)
                                    .foregroundColor(tag.colour)
                                    .font(.caption)
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .padding(.bottom, 5)
                }
                Section(header: Text("OUTSTANDING")) {
                    ForEach($transactionsOutstanding) { $transaction in
                        Button {
                            showTransactionDetailsSheet.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
                                    Text("\(transaction.people[0]), \(transaction.people[1])")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", transaction.money))
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailView(transaction: $transaction)
                        }
                    }
                }
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                        ForEach(transactionsDueInAWeek) { transaction in
                            Button {
                                showTransactionDetailsSheet.toggle()
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(transaction.name)
                                            .foregroundColor(.black)
                                        Text("\(transaction.people[0]), \(transaction.people[1])")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("$" + String(format: "%.2f", transaction.money))
                                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                        .font(.title2)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                HStack {
                    Button {
                        showAddTransactionSheet.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                    Button {
                        print("filter search")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .sheet(isPresented: $showAddTransactionSheet) {
                    }
                }
                .font(.system(size: 23))
                .padding(.top, 90)
            }
        }
    }


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
