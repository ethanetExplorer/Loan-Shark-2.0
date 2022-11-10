//
//  TransactionDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 9/11/22.
//

import SwiftUI

struct TransactionDetailView: View {
    
    @State var showBillSplit: Bool
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
                    Section(header: Text("Transaction details")) {
                        HStack{
                            Text("Title")
                            TextField("Add title", text: $0.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("People:")
                            Picker ("People", selection: $selectedContact) {
                                ForEach(contacts, id:\.self) {
                                    Text($0)
                                }
                            }
                        }
                        HStack{
                            Text("Amount of money:")
                            TextField("Amount", value: $0.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        DatePicker("Due by", selection: $0.dueDate, in: .now..., displayedComponents: .date)
                        Picker("Transaction type", selection: $0.transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section(header: Text("Options")) {
                        Toggle(isOn: $0.isDetailSyncronised) {
                            Text("Syncronise details")
                        }
                    }
                }
                Button{
                    print("Saved transaction")
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
            Button{
                print("Saved transaction")
            } label: {
                Text("Save")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .navigationTitle("Details")
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(showBillSplit: true)
        TransactionDetailView(showBillSplit: false)
    }
}
