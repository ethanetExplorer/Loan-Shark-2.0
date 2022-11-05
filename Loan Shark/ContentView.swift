//
//  Banker_Collab_AppApp.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct ContentView: View {
	
//	@StateObject var transactionManager = TransactionManager()
	
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PeopleView()
                .tabItem {
                    Label("Contacts", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
