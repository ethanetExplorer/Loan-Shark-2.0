//
//  PeopleView.swift
//  Test environment
//
//  Created by Ethan Lim on 1/11/22.
//
import SwiftUI
import UIKit
import Contacts

struct PeopleView: View {
    
    @ObservedObject var manager: TransactionManager
    @State var isContactSheetPresented = false
    @State var searchTerm = ""
    @State var listToFetchFrom: [Contact]
//    var contactsSelectedForTransactions: [Contact] {
//        manager.contactsList.filter { $0.selectedForTransaction == true}
//    }

    var body: some View {
        NavigationView {
            //Change manager.contactsList to contactsSelectedForTransactions once the persistence issue is solved
            List(listToFetchFrom) { contact in
                NavigationLink {
                    PersonDetailView(manager: TransactionManager(), person: contact)
                } label: {
                    HStack {
                        Text(contact.name)
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                }
            }
            .navigationTitle("Contacts")
            .searchable(text: $manager.contactsSearchTerm, prompt: Text("Search for a contact"))
        }
        .onAppear {
            listToFetchFrom = manager.contactsList
        }
        .onChange(of: manager.contactsSearchTerm) { newValue in
            if newValue.isEmpty {
                listToFetchFrom = manager.contactsList
//                print("fetching from contacts list")
            } else {
                listToFetchFrom = manager.contactsSearchResult
//                print("fetching from search result")
            }
        }
    }
}
