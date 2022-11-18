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
    
    var body: some View {
        NavigationView {
            List(manager.contactsList.filter({ contact in
                contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
            })) { contact in
                NavigationLink {
                    PersonDetailView(manager: TransactionManager(), person: contact)
                } label: {
                    HStack {
                        Text(contact.name)
                    }
                }
            }
            .navigationTitle("All people!")
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus.app")
                }
            }
            .searchable(text: $searchTerm)
        }
    }
}
    
    struct ContactView_Previews: PreviewProvider {
        static var previews: some View {
            PeopleView(manager: TransactionManager(), isContactSheetPresented: true, searchTerm: "")
        }
    }

