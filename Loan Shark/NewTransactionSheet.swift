//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du Du Du Du on 6/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    @StateObject var manager = TransactionManager()
    @State var isDetailSyncronised: Bool = false
    @State var dueDate = Date()
    
    @State var transactionType = ""
    var transactionTypes = ["Select","Loan","Bill split"]
    @Environment(\.dismiss) var dismiss

    var decimalNumberFormat: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }
    
    @State var newTransaction = Transaction(name: "", people: [""], dueDate: Date.now, isPaid: false, isBillSplitTransaction: false, money: 0)
    @Binding var transactions: [Transaction]

    @State var peopleInvolved = ""
    var contacts = ["Contact", "Dhoby Ghaut", "Bras Basah", "Esplanade", "Promenade", "Nicoll Highway", "Stadium", "Mountbatten", "Dakota", "Paya Lebar", "MacPherson", "Tai Seng", "Bartley", "Serangoon", "Lorong Chuan", "Bishan", "Marymount", "Caldecott", "Botanic Gardens", "Farrer Road", "Holland Village", "Buona Vista", "one-north", "Kent Ridge", "Haw Par Villa", "Pasir Panjang", "Labrador Park", "Telok Blangah", "HarbourFront", "Keppel", "Cantonment", "Prince Edward Road", "Marina Bay", "Bayfront"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Transaction details")) {
                        HStack {
                            Text("Title")
                            TextField("Title", text: $newTransaction.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker("Transaction type", selection: $transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("People", selection: $peopleInvolved){
                            ForEach(contacts, id: \.self){
                                Text($0)
                            }
                        }
//                        newTransaction.people.append(peopleInvolved)
                        HStack{
                            Text("Amount of money:")
                            TextField("Amount", value: $newTransaction.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        DatePicker("Due by", selection: $newTransaction.dueDate, in: Date.now..., displayedComponents: .date)
                    }
                    Section(header: Text("Options")){
                        Toggle(isOn: $isDetailSyncronised){
                            Text("Syncronise details")
                        }
                    }
                }
                Button {
                    transactions.append(newTransaction)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("New transaction")
        }
    }
}


struct NewTransactionSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionSheet(transactions: .constant([])) 
    }
}
