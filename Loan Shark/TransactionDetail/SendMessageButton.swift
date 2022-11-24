//
//  SendMessageButton.swift
//  Loan Shark
//
//  Created by Yuhan Du on 20/11/22.
//

import SwiftUI

struct SendMessageButton: View {
    
    var transaction: Transaction
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
                .foregroundColor(.blue)
            }
            .sheet(isPresented: $isSheetPresented) {
                MessageView(message: "Hi \(person.name ?? ""), could you repay me \(decimalNumberFormat.string(for: person.money)!) for \(transaction.name) as soon as possible please?\nThank you!", recipient: phoneNumber)
            }
        }
    }
}
