//
//  PeopleView.swift
//  Test environment
//
//  Created by Ethan Lim on 1/11/22.
//

import SwiftUI



struct PeopleView: View {
    @State var peopleList = [
        Person(name: "Jason", creditScore: 10),
        Person(name: "Jackson", creditScore: -10)
    ]
    
    var body: some View {
        NavigationView{
            List($peopleList) { $person in
                NavigationLink {
                    PersonDetailView(person: $person)
                } label: {
                    HStack {
                        Text(person.name)
                        Spacer()
                        Text(String(person.creditScore))
                    }
                    .foregroundColor(person.isCreditScoreNegative ? .red : .black)
                }
            }
            .navigationTitle("All people")
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

