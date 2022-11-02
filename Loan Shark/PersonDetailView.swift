//
//  PersonDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//

import SwiftUI



struct PersonDetailView: View {
    @Binding var person: Person
    
    struct Numerous: Identifiable{
        var id = UUID()
        var number: Int
    }
    
    var numbersArraY = [
        Numerous(number: 1),
        Numerous(number: 2),
        Numerous(number: 3),
        Numerous(number: 4),
        Numerous(number: 5)
    ]
    
    @State var showTransactionDetailsSheet = false
    
#warning("ALL PLACEHOLDER VALUES")
    
    var body: some View {
        VStack(alignment: .leading){
            Text ("Credit score: 50")
                .padding(.leading)
            NavigationView{
                //                List(numbersArraY) { Numerous in
                //                    HStack {
                //                        VStack(alignment: .leading){
                //                            Text("Transaction")
                //                            Text("Amount of money: $50")
                //                                .font(.caption)
                //                        }
                //                        Spacer()
                //                        Text(String(10))
                List {
                    Section(header: Text("ONGOING TRANSACTIONS")) {
                        ForEach(numbersArraY) { numerous in
                            Button {
                                
                            } label: {
                                HStack{
                                    VStack{
                                        Text("Example transaction \(numerous.number)")
                                            .foregroundColor(.black)
                                        Text("Due in 5 days")
                                        
                                    }
                                    Spacer()
                                    Text("$" + String(format: "%.2f", transaction.money))
                                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                        .font(.title2)
                                }
                            }
                        }
                    }
                    Section(header: Text("TRANSACTION HISTORY")) {
                        ForEach(numbersArraY) { numerous in
                            Button {
                                
                            } label: {
                                HStack{
                                    VStack{
                                        Text("Example transaction \(numerous.number)")
                                            .foregroundColor(.black)
                                        Text("Due in 5 days")
                                        
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
            .navigationTitle("Jason")
        }
    }
}


struct contactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: .constant(Person(name: "Jason", creditScore: 10)))
    }
}
