//
//  BillSplitDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//

import SwiftUI

struct BillSplitDetailView: View {
    
    @Binding var transaction: Transaction
    
    @State var isDetailSyncronised: Bool = false
    
    @State var dueDate = Date()
    
    var transactionTypes = ["Bill split", "Loan"]
    @State var selectedTransactionType = "Loan"
    
    //    var tagsList = [Tag(name: "Loan", icon: "banknote", color: .green), Tag(name: "Meal", icon: "fork.knife", color: .red),
    //                    Tag(name: "Gift", icon: "gift", color: .purple)]
    @State var selectedTag = "Bill split"
    
    var body: some View {
        NavigationView {
            VStack{
                Form{
                    Section(header: Text("Transaction details")){
                        HStack{
                            Text("Title")
                            TextField("Add title", text: $transaction.name)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("People involved:")
                            //                            TextField("Add people", text: $transaction.people)
                            //                                .foregroundColor(.gray)
                            //                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Amount of money owed:")
                            TextField("Add amount of money owed", value: $transaction.money, formatter: NumberFormatter())
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        DatePicker("Due by", selection: $dueDate, in: ...dueDate, displayedComponents: .date)
                        Picker("Transaction type", selection: $selectedTransactionType) {
                            ForEach(transactionTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section(header: Text("Options")){
                        Toggle(isOn: $isDetailSyncronised){
                            Text("Syncronise details")
                        }
                        //                    HStack{
                        //                        Picker("Tags", selection: $selectedTag){
                        //                            ForEach(tagsList) { tagItem in
                        //                                HStack{
                        //                                    Image(systemName: tagItem.icon)
                        //                                    Text(tagItem.name)
                        //                                }
                        //                            }
                        //                        }
                        //                    }
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
            .navigationTitle("Details")
        }
    }
}

struct BillSplitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BillSplitDetailView(transaction: .constant(Transaction(name: "Meal", people: ["Jason"], money: 50, dueDate: .now)))
        //        appliedTags: [0],
    }
}
