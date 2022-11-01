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
        Transaction(name: "Meal", people: ["Jason", "Jackson"], money: 500, dueDate: Date("2022/12/25")),//, appliedTags: 0),
        Transaction(name: "Money loan", people: ["Jerome"], money: 10, dueDate: Date("2022/12/25")),//, appliedTags: 1),
        Transaction(name: "MacBook gift", people: ["Jonathan"], money: 2999, dueDate: Date("2022/12/25"))//, appliedTags: 2)
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
                Section(header: Text("Outstanding transactions")) {
                    ForEach($transactionsOutstanding) { $transaction in
                        Button {
                            showTransactionDetailsSheet.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(transaction.name)
                                        .foregroundColor(.black)
                                    Text(transaction.people[0] + String(transaction.people[1]))
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
                Section(header: Text("Due in next 7 days")) {
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
