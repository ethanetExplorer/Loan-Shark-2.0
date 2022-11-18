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
    @State var isSelected = false
    
    var body: some View {
        List {
            if manager.isSearchTermEmpty {
                ForEach(manager.contactsList) { contact in
                    HStack {
                        Button {
                            contact.selected.toggle()
                        } label: {
                            contact.selected ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle")
                        }
                        Text(contact.name)
                            .tag(contact.name)
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
