//
//  Debt.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct PeopleView: View {
    @State var peopleList = [
        Person(name: "Jason", creditScore: 10),
        Person(name: "Jackson", creditScore: -10)
    ]
    
    @State var isPeopleDetailViewPresented = false
    
    var body: some View {
        List(peopleList) { person in
            HStack {
                Text(person.name)
                Spacer()
                Text(String(person.creditScore))
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
