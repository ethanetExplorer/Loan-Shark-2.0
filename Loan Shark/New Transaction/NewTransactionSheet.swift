//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du Du Du Du on 6/11/22.
//
// Duhan Du Du Du

import SwiftUI

var decimalNumberFormat: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.allowsFloats = true
    numberFormatter.numberStyle = .currency
    numberFormatter.currencySymbol = "$"
    return numberFormatter
}

struct NewTransactionSheet: View {
    
    var manager: TransactionManager
    @State var isDetailSynchronised: Bool = false
    @State var dueDate = Date()
    @State var transactionType = "Select"
    
    var fieldsUnfilled: Bool {
        name.isEmpty || transactionType == "Select" || people.filter({ $0.contact != nil }).count < 1
    }
    var transactionTypes = ["Select", "Loan", "Bill split"]
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var people: [Person] = [Person(contact: nil, money: 0, dueDate: .now, hasPaid: false)]
    
    @Binding var transactions: [Transaction]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Transaction details")) {
                        HStack {
                            Text("Title")
                            TextField("Title", text: $name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker("Transaction type", selection: $transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    if transactionType == "Bill split" {
                        Section {
                            Toggle(isOn: $isDetailSynchronised) {
                                Text("Synchronise details")
                            }
                        } footer: {
                            Text("Toggle this to distribute the total amount of the transaction equally between all selected contacts, and for the same due date to apply for all. ")
                        }
                    }
                    
                    if transactionType == "Loan" {
                        let contactBinding = Binding {
                            if let firstPereson = people.first {
                                return firstPereson.contact
                            }
                            return nil
                        } set: { contact in
                            people = [Person(contact: contact, money: people[0].money!, dueDate: people[0].dueDate!, hasPaid: false)]
                        }
                        
                        NavigationLink {
                            PeopleSelectorView(manager: manager, selectedContact: contactBinding)
                        } label: {
                            HStack {
                                Text("Who")
                                Spacer()
                                Text(people[0].name ?? "No Contact Selected")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        HStack {
                            Text("Amount")
                            TextField("Amount", value: $people[0].money, formatter: decimalNumberFormat)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        
                        let bindingDate = Binding {
                            people[0].dueDate ?? .now
                        } set: { newValue in
                            people[0].dueDate = newValue
                        }
                        
                        DatePicker("Due by", selection: bindingDate, in: Date.now..., displayedComponents: .date)
                    } else if transactionType == "Bill split" && !isDetailSynchronised {
                        if !people.isEmpty {
                            let excludedContacts = people.compactMap({
                                $0.contact
                            })
                            
                            ForEach($people, id: \.name) { $person in
                                Section(header: Text(person.name ?? "No Contact Selected")) {
                                    NavigationLink {
                                        PeopleSelectorView(manager: manager, selectedContact: $person.contact, excludedContacts: excludedContacts)
                                    } label: {
                                        HStack {
                                            Text("Who")
                                            Spacer()
                                            Text(person.name ?? "No Contact Selected")
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    
                                    HStack {
                                        Text("Amount")
                                        TextField("Amount", value: $person.money, formatter: decimalNumberFormat)
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.trailing)
                                            .keyboardType(.decimalPad)
                                    }
                                    
                                    let dueDateBinding = Binding {
                                        person.dueDate!
                                    } set: { newValue in
                                        person.dueDate = newValue
                                    }

                                    DatePicker("Due by", selection: dueDateBinding, in: Date.now..., displayedComponents: .date)
                                }
                            }
                        }

                        Section {
                            if !people.contains(where: {
                                $0.contact == nil
                            }) {
                                Button {
                                    withAnimation {
                                        people.append(Person(contact: nil, money: 0, dueDate: .now, hasPaid: false))
                                    }
                                } label: {
                                    Text("Add contacts")
                                }
                            }
                            
                            if !people.isEmpty {
                                Button {
                                    withAnimation {
                                        _ = people.removeLast()
                                    }
                                } label: {
                                    Text("Remove contact")
                                }
                            }
                        }

                    }
                    else if transactionType == "Bill split" && isDetailSynchronised {
                        
                        let contactsBinding = Binding {
                            people.compactMap {
                                $0.contact
                            }
                        } set: { newValue in
                            let money = people[0].money
                            people = newValue.map({ contact in
                                Person(contact: contact, money: money!, dueDate: dueDate)
                            })
                        }
                        
                        NavigationLink {
                            MultiplePeopleSelectorView(manager: manager, selectedContacts: contactsBinding)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Who")
                                
                                let names = people
                                    .compactMap {
                                        $0.name
                                    }
                                
                                if names.isEmpty {
                                    Text("No one selected")
                                        .font(.caption)
                                } else {
                                    Text(names.joined(separator: ", "))
                                        .font(.caption)
                                }
                            }
                        }
                        HStack {
                            Text("Amount each")
                            TextField("Amount each", value: $people[0].money, formatter: decimalNumberFormat)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        DatePicker("Due by", selection: $dueDate, in: Date.now..., displayedComponents: .date)
                    }
                }
                
                Button {
                    let transactionTypeItem: TransactionTypes = {
                        switch transactionType {
                        case "Loan":
                            return .loan
                        case "Bill split":
                            return isDetailSynchronised ? .billSplitSync : .billSplitNoSync
                        default: return .unselected
                        }
                    }()
                    let transaction = Transaction(name: name,
                                                  people: people.filter({
                        $0.contact != nil
                    }), transactionType: transactionTypeItem)
                    
                    transactions.append(transaction)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .opacity(fieldsUnfilled ? 0.5 : 1)
                }
                .disabled(fieldsUnfilled)
                .padding(.horizontal)
            }
            .navigationTitle("New transaction")
            .onChange(of: transactionType) { newValue in
                people = [Person(contact: nil, money: 0, dueDate: .now, hasPaid: false)]
            }
            .onChange(of: isDetailSynchronised) { newValue in
                people = [Person(contact: nil, money: 0, dueDate: .now, hasPaid: false)]
            }
        }
    }
}

