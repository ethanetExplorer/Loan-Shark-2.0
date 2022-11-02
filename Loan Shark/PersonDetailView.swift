//
//  PersonDetailView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 1/11/22.
//

import SwiftUI



struct PersonDetailView: View {
    
    @Binding var person : Person
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Construction in progress")
        }
    }
}
struct contactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: .constant(Person(name: "Jeremy", creditScore: 20)))
    }
}
