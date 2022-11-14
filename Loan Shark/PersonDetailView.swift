//
//  PersonDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//
import SwiftUI

struct PersonDetailView: View {
    
    var person : Person
    
    struct Placeholder: Identifiable {
        var id: UUID?
        var number: Int
    }
    
    @State var placeholderArray = [Placeholder(number: 1), Placeholder(number:2), Placeholder(number:3)
    ]
    
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
                        ForEach(placeholderArray) { placeholder in
                            Button {
                                
                            } label: {
                                HStack{
                                    VStack{
                                        Text("Example transaction \(placeholder.number)")
                                            .foregroundColor(.black)
                                        Text("Due in 5 days")
                                        
                                    }
                                    Spacer()
                                    Text("$50")
                                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                        .font(.title2)
                                }
                            }
                        }
                    }
                    Section(header: Text("TRANSACTION HISTORY")) {
                        ForEach(placeholderArray) { placeholder in
                            Button {
                                
                            } label: {
                                HStack{
                                    VStack{
                                        Text("Example transaction \(placeholder.number)")
                                            .foregroundColor(.black)
                                        Text("Due in 5 days")
                                    }
                                    Spacer()
                                    Text("$50")
                                        .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                        .font(.title2)
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle(person.name)
        }
    }
}


struct contactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(name: "Jeremy"))
    }
}
