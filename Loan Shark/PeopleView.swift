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
            .navigationTitle("All people!")
            .toolbar {
                Menu {
                    Button {
                        
                    } label: {
                        Label("Alphabetical", systemImage: "a.circle")
                    }
                    Button {
                        
                    } label: {
                        Label("Credit Score", systemImage: "creditcard")
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
    
    
    struct ContactView_Previews: PreviewProvider {
        static var previews: some View {
            PeopleView()
        }
    }
}
