//
//  PeopleSelectorView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 16/11/22.
//

import SwiftUI

struct PeopleSelectorView: View {
    
    @StateObject var manager = TransactionManager()
    @State var personSelected: Person?
    @State var searchTerm = ""
        
    var body: some View {
        List {
            ForEach(manager.contactsList) { contact in
                HStack {
                    Button {
                        personSelected = contact
                    } label: {
                        Image(systemName: personSelected?.id == contact.id ? "checkmark.circle.fill" : "circle")
                    }
                    Text(contact.name)
                        .tag(contact.name)
                }
            }
        }
        .searchable(text: .constant(""), prompt: Text("Search for a person"))
        .navigationTitle("Select people")
        .onAppear {
            personSelected = manager.contactsList.first
        }
    }
}

struct PeopleSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleSelectorView()
    }
}
