//
//  Debt.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct ContactsView: View {
    @State var contactsList = [
        Contact(name: "Jason", creditScore: 10),
        Contact(name: "Jackson", creditScore: -10)
    ]
    var body: some View {
        List(contactsList) { contact in
            Text(contact.name)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
