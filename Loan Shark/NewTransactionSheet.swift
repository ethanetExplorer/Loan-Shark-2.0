//
//  NewTransactionSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du Du Du Du on 6/11/22.
//

import SwiftUI

struct NewTransactionSheet: View {
    
    @StateObject var manager = TransactionManager()
    
    @State var newTransaction = Transaction(name: "", people: [""], dueDate: "", isPaid: false, isBillSplitTransaction: false, money: 0)
    let transactionTypes = ["Loan", "Bill Split"]
    
    @State var selectedContact = ""
    var contacts = ["Dhoby Ghaut", "Bras Basah", "Esplanade", "Promenade", "Nicoll Highway", "Stadium", "Mountbatten", "Dakota", "Paya Lebar", "MacPherson", "Tai Seng", "Bartley", "Serangoon", "Lorong Chuan", "Bishan", "Marymount", "Caldecott", "Botanic Gardens", "Farrer Road", "Holland Village", "Buona Vista", "one-north", "Kent Ridge", "Haw Par Villa", "Pasir Panjang", "Labrador Park", "Telok Blangah", "HarbourFront", "Keppel", "Cantonment", "Prince Edward Road", "Marina Bay", "Bayfront"]
    
    var decimalNumberFormat: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section{
                        TextField("Title", text: $newTransaction.name)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        Picker("Transaction type", selection: $newTransaction.isBillSplitTransaction) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker ("Contact", selection: $selectedContact) {
                            ForEach(contacts, id:\.self) {
                                Text($0)
                            }
                        }
                        TextField("Amount", value: $newTransaction.money, formatter: decimalNumberFormat)
                    }
                    Section {
                        DatePicker("Due by", selection: $newTransaction.dueDate, in: .now..., displayedComponents: .date)
                        HStack {
                            TextField("Amount", value: $newTransaction.money, formatter: decimalNumberFormat)
                        }
                    }
                }
            }
            Button {
                manager.allTransactions.append(newTransaction)
            } label: {
                Text("Save transaction")
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
    }
}


struct NewTransactionSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionSheet()
    }
}
