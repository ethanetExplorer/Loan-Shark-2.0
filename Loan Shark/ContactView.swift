//
//  Debt.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct ContactsView: View {
    @State var contactsList = [
    
    ]
    var body: some View {
        List(contacts) { contacts in
            Text(contacts.name)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
