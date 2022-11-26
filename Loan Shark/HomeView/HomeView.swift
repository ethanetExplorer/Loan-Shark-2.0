//
//  HomeView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
// ...
import SwiftUI
import UIKit
import UserNotifications

enum EditButtons {
    case delete
    case cancel
    case save (Transaction)
}

struct HomeView: View {
    
    @ObservedObject var manager: TransactionManager
    
    @State var showNewTransactionSheet = false
    
    @State var showDeleteAlert = false
    @State var addTransactionNotification = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Overdue")) {
                    ForEach($manager.sortedTransactions) { $transaction in
                        if transaction.transactionStatus == .overdue {
                            TransactionRowView(manager: manager, transaction: $transaction)
                                .swipeActions {
                                    Button {
                                        showDeleteAlert = true
                                    } label: {
                                        HStack{
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .tint(Color("RadRed"))
                                }
                                .alert("Are you sure you want to delete this transaction?", isPresented: $showDeleteAlert, actions: {
                                    Button(role: .cancel) {
                                        print("CanCeLLeD")
                                    } label: {
                                        Text("Cancel")
                                    }
                                    Button(role: .destructive) {
                                        if let transactionIndex = manager.allTransactions.firstIndex(where: {
                                            $0.id == transaction.id
                                        }) {
                                            manager.allTransactions.remove(at: transactionIndex)
                                        }
                                    } label: {
                                        Text("Delete")
                                    }
                                }, message: {
                                    Text("This action cannot be undone.")
                                })
                        }
                    }
                }
                
                Section(header: Text("Due in 7 days")) {
                    ForEach($manager.sortedTransactions) { $transaction in
                        if transaction.transactionStatus == .dueInOneWeek {
                            TransactionRowView(manager: manager, transaction: $transaction)
                                .swipeActions {
                                    Button {
                                        showDeleteAlert = true
                                    } label: {
                                        HStack{
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .tint(Color("RadRed"))
                                }
                                .alert("Are you sure you want to delete this transaction?", isPresented: $showDeleteAlert, actions: {
                                    Button(role: .cancel) {
                                        print("CanCeLLeD")
                                    } label: {
                                        Text("Cancel")
                                    }
                                    Button(role: .destructive) {
                                        if let transactionIndex = manager.allTransactions.firstIndex(where: {
                                            $0.id == transaction.id
                                        }) {
                                            manager.allTransactions.remove(at: transactionIndex)
                                        }
                                    } label: {
                                        Text("Delete")
                                    }
                                }, message: {
                                    Text("This action cannot be undone.")
                                })

                        }
                    }
                }
                Section(header: Text("Others")) {
                    ForEach($manager.sortedTransactions) { $transaction in
                        if transaction.transactionStatus == .unpaid {
                            TransactionRowView(manager: manager, transaction: $transaction)
                                .swipeActions {
                                    Button {
                                        showDeleteAlert = true
                                    } label: {
                                        HStack{
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .tint(Color("RadRed"))
                                }
                                .alert("Are you sure you want to delete this transaction?", isPresented: $showDeleteAlert, actions: {
                                    Button(role: .cancel) {
                                        print("CanCeLLeD")
                                    } label: {
                                        Text("Cancel")
                                    }
                                    Button(role: .destructive) {
                                        if let transactionIndex = manager.allTransactions.firstIndex(where: {
                                            $0.id == transaction.id
                                        }) {
                                            manager.allTransactions.remove(at: transactionIndex)
                                        }
                                    } label: {
                                        Text("Delete")
                                    }
                                }, message: {
                                    Text("This action cannot be undone.")
                                })

                        }
                    }
                }
                Section(header: Text("Completed")) {
                    ForEach($manager.sortedTransactions) { $transaction in
                        if transaction.transactionStatus == .paidOff {
                            TransactionRowView(manager: manager, transaction: $transaction)
                                .swipeActions {
                                    Button {
                                        showDeleteAlert = true
                                    } label: {
                                        HStack{
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .tint(Color("RadRed"))
                                }
                                .alert("Are you sure you want to delete this transaction?", isPresented: $showDeleteAlert, actions: {
                                    Button(role: .cancel) {
                                        print("CanCeLLeD")
                                    } label: {
                                        Text("Cancel")
                                    }
                                    Button(role: .destructive) {
                                        if let transactionIndex = manager.allTransactions.firstIndex(where: {
                                            $0.id == transaction.id
                                        }) {
                                            manager.allTransactions.remove(at: transactionIndex)
                                        }
                                    } label: {
                                        Text("Delete")
                                    }
                                }, message: {
                                    Text("This action cannot be undone.")
                                })

                        }
                    }
                }
            }
            .navigationTitle("Home")
            .searchable(text: $manager.searchTerm, prompt: Text("Search for a transaction"))
            .toolbar {
                Button {
                    showNewTransactionSheet = true
                } label: {
                    Image(systemName: "plus.app")
                }
                .sheet(isPresented: $showNewTransactionSheet) {
                    NewTransactionSheet(manager: manager, transactions: $manager.allTransactions)
                }
                Picker(selection: $manager.selectedSortMethod) {
                    Label("Time Due", systemImage: "clock")
                        .tag(SortingMethods.timeDue)
                    Label("Amount Due", systemImage: "dollarsign.circle")
                        .tag(SortingMethods.amount)
                    Label("Alphabetically", systemImage: "line.3.horizontal.decrease.circle")
                        .tag(SortingMethods.alphabetically)
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
    func removeNotification(for transaction: Transaction) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [transaction.id.uuidString])
        print("HV: Notification is" + String(transaction.isNotificationEnabled))
    }
    
    func addNotification(for transaction: Transaction) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            let unpaidPeople = transaction.people.filter { $0.hasPaid == false }
            let peopleWhoPaid = transaction.people.filter{$0.hasPaid}
            let overdueTransactions = manager.allTransactions
            var amountOfMoneyPaid: Double {
                peopleWhoPaid.reduce(0) { partialResult, person in
                    partialResult + (person.money!)
                }
            }
            let amountOfMoneyUnpaid = transaction.totalMoney - amountOfMoneyPaid
            
            if overdueTransactions.count > 1 {
                content.title = "Overdue transactions"
                content.subtitle = "You have \(String(overdueTransactions.count)) overdue transactions"
            }
            else if overdueTransactions.count == 1 && transaction.transactionType == .billSplitNoSync || transaction.transactionType == .billSplitSync {
                content.title = "Overdue loans"
                content.subtitle = "Remind \(unpaidPeople.map { $0.name! }.joined(separator: ", ")) to return you \(amountOfMoneyUnpaid)"
            }
            else if overdueTransactions.count == 1 && transaction.transactionType == .loan {
                content.title = "Overdue loan"
                content.subtitle = "Remind \(overdueTransactions[0].people[0].name ?? "") to return you $\(String(format: ".%2f", overdueTransactions[0].people[0].money!))"
            }
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 7
            
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents , repeats: true)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            
            let request = UNNotificationRequest(identifier: transaction.id.uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        center.getNotificationSettings{ settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
                print("HV: Notification is" + String(transaction.isNotificationEnabled))
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Skill issue")
                        print("HV: Notification is" + String(transaction.isNotificationEnabled))
                    }
                }
            }
        }
    }
}


