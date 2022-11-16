//
//  PeopleSelectorView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 16/11/22.
//

import SwiftUI

struct PeopleSelectorView: View {
    
    @StateObject var manager = TransactionManager()
    @State var peopleSelected = []
    
    var body: some View {
        List {
            if manager.isSearchTermEmpty {
                ForEach(manager.contactsList) { car in
                    HStack {
                        Button {
                            print("HAHAHA")
                        } label: { Image(systemName: "circle")}
                        Text(car.name)
                            .tag(car.name)
                    }
                }
            } else {
                ForEach(manager.filteredContacts) { car in
                    HStack {
                        Button {
                            
                        } label: { Image(systemName: "pc")}
                        Text(car.name)
                            .tag(car.name)
                    }
                }
            }
        }
        .navigationTitle("Select people").lineLimit(10)
        .searchable(text: $manager.personToSearch, prompt: Text("Search for a person"))
    }
}

struct PeopleSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleSelectorView()
    }
}
