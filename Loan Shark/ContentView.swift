//
//  ContentView.swift
//  Loan Shark
//
//  Created by Ethan Lim on 6/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var transactionManager = TransactionManager()
    
    var body: some View {
		TabView {
			HomeView(manager: transactionManager)
				.tabItem {
					Label("Home", systemImage: "house")
				}
//			PeopleView(manager: transactionManager)
//				.tabItem {
//					Label("Contacts", systemImage: "person.circle")
//				}
			}
		}
	}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
