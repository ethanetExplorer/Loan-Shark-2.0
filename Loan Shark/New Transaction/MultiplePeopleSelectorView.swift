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
    @State var listToFetchFrom: [Contact]
    @State var reload = false
    
    var body: some View {
        List {
            ForEach(listToFetchFrom) { contact in
                
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
        .searchable(text: $manager.contactsSearchTerm, prompt: Text("Search for a contact"))
        .navigationTitle("Select people")
        .onAppear {
            listToFetchFrom = manager.contactsList
        }
        .onChange(of: manager.contactsSearchTerm) { newValue in
            if newValue.isEmpty {
                listToFetchFrom = manager.contactsList
                print("fetching from contacts list")
            } else {
                listToFetchFrom = manager.contactsSearchResult
                print("fetching from search result")
            }
        }
    }
}
