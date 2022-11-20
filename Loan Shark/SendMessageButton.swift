//
//  SendMessageButton.swift
//  Loan Shark
//
//  Created by Yuhan Du on 20/11/22.
//

import SwiftUI

struct SendMessageButton: View {
    
    var person: Person
    
    @State var isSheetPresented = false
    
    var body: some View {
        if let phoneNumber = person.contact?.phoneNumber, MessageView.canSendText {
            Button {
                isSheetPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "message")
                    Text("Send reminder")
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                #warning("Please change this.")
                MessageView(message: "I DEMAND PAYMENT OF \(decimalNumberFormat.string(for: person.money)!) IMMEDIATELY.", recipient: phoneNumber)
            }
        }
    }
}
