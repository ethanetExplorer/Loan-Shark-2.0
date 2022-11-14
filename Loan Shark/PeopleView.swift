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
    @State var contactsList: [Person]
    @State var isContactSheetPresented = false
    @State var searchTerm = ""
    
    var body: some View {
        NavigationView {
            List(contactsList.filter({ contact in
                contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
            })) { contact in
                NavigationLink {
                    PersonDetailView(person: contact)
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
            .onAppear {
                let store = CNContactStore()
                
                store.requestAccess(for: .contacts) { (granted, error) in
                    if let error = error {
                        print("failed to request access", error)
                        return
                    }
                    if granted {
                        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
                        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            do {
                                var contacts: [Person] = []
                                
                                try store.enumerateContacts(with: request) { (contact, stopPointer) in
                                    contacts.append(Person(name: contact.givenName + " " + contact.familyName))
                                }
                                
                                DispatchQueue.main.async {
                                    self.contactsList = contacts
                                }
                            } catch let error {
                                print("Failed to enumerate contact", error)
                            }
                        }
                    } else {
                        print("access denied")
                    }
                }
            }
            .searchable(text: $searchTerm)
        }
    }
    
    
//    struct ContactView_Previews: PreviewProvider {
//        static var previews: some View {
//            PeopleView()
//        }
//    }
}
