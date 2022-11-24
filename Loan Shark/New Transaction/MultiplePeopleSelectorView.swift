//
//  MultiplePeopleSelectorView.swift
//  Loan Shark
//
//  Created by Yu Duhan on 19/11/22.
//

import SwiftUI

struct MultiplePeopleSelectorView: View {
    
    @ObservedObject var manager: TransactionManager
    
    @Binding var selectedContacts: [Contact]
    
    @State var searchTerm = ""
    @State var reload = false
    
    var body: some View {
        List {
            ForEach(manager.contactsList.filter({ contact in
                contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
            })) { contact in
                
                let contactIndex = selectedContacts.firstIndex {
                    $0.id == contact.id
                }
                
                Button {
                    withAnimation {
                        if let contactIndex {
                            selectedContacts.remove(at: contactIndex)
                        } else {
                            selectedContacts.append(contact)
                        }
                        reload.toggle()
                    }
                } label: {
                    Label(contact.name,
                          systemImage: contactIndex != nil ? "checkmark.circle.fill" : "circle")
                    .opacity(reload ? 1 : 1)
                }
                .foregroundColor(Color("PrimaryTextColor"))            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a person"))
        .navigationTitle("Select people")
    }
}
