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
    
    #warning("PLACEHOLDER")
    
    var body: some View {
        VStack(alignment: .leading){
            NavigationView{
                VStack{
                    #warning("ALSO A PLACEHOLDER")
                    Section{
                    Text("Jason")
                        .font(.title)
                        .bold()
                        .padding([.top, .leading, .trailing], 10)
                    Text("Credit score: 50")
                        .font(.subheadline)
                        .padding([.leading, .bottom, .trailing], 10)
                        }
                    List(numbersArraY) { Numerous in
                        HStack {
                            VStack(alignment: .leading){
                                Text("Transaction")
                                Text("Amount of money: $50")
                                    .font(.caption)
                            }
                            Spacer()
                            Text(String(10))
                            
                        }
                    }
                }
            }
        }
    }
}
struct contactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: .constant(Person(name: "Jason", creditScore: 10)))
    }
}
