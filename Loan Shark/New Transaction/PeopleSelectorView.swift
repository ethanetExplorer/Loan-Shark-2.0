//
//  PeopleSelectorView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 16/11/22.
//

import SwiftUI

struct PeopleSelectorView: View {
    
    @ObservedObject var manager: TransactionManager
    
    @Binding var selectedContact: Contact?
    
    @Environment(\.dismiss) var dismiss
    
    var excludedContacts: [Contact] = []
    
    @State var searchTerm = ""
    @State var reload = false
    
    var body: some View {
        List {
            ForEach(manager.contactsList
                .filter { contact in
                    contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
                }
                .filter { contact in
                    if (selectedContact?.id == contact.id) {
                        return true
                    } else {
                        return !excludedContacts.contains(where: {
                            $0.id == contact.id
                        })
                    }
                }
            ) { contact in
                Button {
                    withAnimation {
                        if selectedContact?.id == contact.id {
                            selectedContact = nil
                        } else {
                            selectedContact = contact
                            dismiss()
                        }
                        
                        reload.toggle()
                    }
                } label: {
                    Label(contact.name,
                          systemImage: selectedContact?.id == contact.id ? "checkmark.circle.fill" : "circle")
                        .opacity(reload ? 1 : 1)
                }
                .foregroundColor(Color("PrimaryTextColor"))
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a person"))
        .navigationTitle("Select people")
    }
}
