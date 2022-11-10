//
//  TransactionDetailSheet.swift
//  Loan Shark
//
//  Created by Ethan Lim on 30/10/22.
//
import SwiftUI

struct TransactionDetailView: View {
    
    
    @StateObject var manager = TransactionManager()
    @Binding var transaction: Transaction
    @State var isDetailSyncronised: Bool = false
    @State var dueDate = Date()
    @State var showBillSplit: Bool
    var transactionTypes = ["Bill split", "Loan"]
    @State var transactionType = "Loan"
    @State var peopleInvolved = ""
    @Environment(\.dismiss) var dismiss

    var decimalNumberFormat: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter
    }
    
    var contacts = ["Dhoby Ghaut", "Bras Basah", "Esplanade", "Promenade", "Nicoll Highway", "Stadium", "Mountbatten", "Dakota", "Paya Lebar", "MacPherson", "Tai Seng", "Bartley", "Serangoon", "Lorong Chuan", "Bishan", "Marymount", "Caldecott", "Botanic Gardens", "Farrer Road", "Holland Village", "Buona Vista", "one-north", "Kent Ridge", "Haw Par Villa", "Pasir Panjang", "Labrador Park", "Telok Blangah", "HarbourFront", "Keppel", "Cantonment", "Prince Edward Road", "Marina Bay", "Bayfront"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Transaction details")) {
                        HStack {
                            Text("Title")
                            TextField("Add title", text: $transaction.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Picker("Transaction type", selection: $transactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        HStack{
                            Text("People involved:")
                            Picker("People", selection: $peopleInvolved){
                                ForEach(contacts, id: \.self){
                                    Text($0)
                                }
                            }
                        }
                        HStack{
                            Text("Amount of money:")
                            TextField("Amount", value: $transaction.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        DatePicker("Due by", selection: $dueDate, in: ...dueDate, displayedComponents: .date)
                    }
                    Section(header: Text("Options")){
                        Toggle(isOn: $isDetailSyncronised){
                            Text("Syncronise details")
                        }
                    }
                }
                Button{
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
            .navigationTitle("Details")
        }
    }
}
struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction: .constant(Transaction(name: "Plane ticket", people: ["Telok Blangah"], dueDate: "2022-12-25", isPaid: false, isBillSplitTransaction: false, money: 200)), showBillSplit: false)
    }
}
