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
//    var contactsSelectedForTransactions: [Contact] {
//        manager.contactsList.filter { $0.selectedForTransaction == true}
//    }

    var body: some View {
        NavigationView {
            //Change manager.contactsList to contactsSelectedForTransactions once the persistence issue is solved
            List(manager.contactsList.filter({ contact in
                contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
            })) { contact in
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
            .searchable(text: $searchTerm)
        }
    }
}
