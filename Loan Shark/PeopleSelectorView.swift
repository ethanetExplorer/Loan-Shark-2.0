//
//  PeopleSelectorView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 16/11/22.
//

import SwiftUI

struct PeopleSelectorView: View {
    
    @ObservedObject var manager: TransactionManager
    
    @Binding var peopleSelected: [Person]
    
    var isMultiSelect: Bool
    
    @State var searchTerm = ""
    @State var reload = false
    
    var body: some View {
        List {
            ForEach(manager.contactsList.filter({ contact in
                contact.name.lowercased().contains(searchTerm.lowercased()) || searchTerm.isEmpty
            })) { contact in
                Button {
                    withAnimation {
                        if isMultiSelect {
                            if let personIndex = peopleSelected.firstIndex(where: {
                                $0.id == contact.id
                            }) {
                                peopleSelected.remove(at: personIndex)
                            } else {
                                peopleSelected.append(contact)
                            }
                        } else {
                            if !peopleSelected.contains(where: {
                                $0.id == contact.id
                            }) {
                                peopleSelected = [contact]
                            }
                        }
                        
                        reload.toggle()
                    }
                } label: {
                    Label(contact.name, systemImage: peopleSelected.contains(where: {
                        $0.id == contact.id
                    }) ? "checkmark.circle.fill" : "circle")
                    .opacity(reload ? 1 : 1)
                }
                .foregroundColor(.primary)
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a person"))
        .navigationTitle("Select people")
    }
}

//struct PeopleSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeopleSelectorView()
//    }
//}
