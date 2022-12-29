//
//  DecimalTextField.swift
//  Loan Shark
//
//  Created by Yuhan Du on 26/11/22.
//
import SwiftUI

struct DecimalTextField: View {
    
    @Binding var amount: Double
    var hint: String
    
    @FocusState var isTextFieldFocused: Bool
    @State var validValue = false
    @State var text = ""
    @State var previousValue = ""
    
    var body: some View {
        TextField(hint, text: $text) {
            let number = decimalNumberFormat.string(for: amount)!
            text = number
        }
        .keyboardType(.decimalPad)
        .focused($isTextFieldFocused)
        .onAppear {
            if validValue == false {
                text = ""
                previousValue = text
            } else {
                let number = decimalNumberFormat.string(for: amount)!
                text = number
                previousValue = text
            }
        }
        .onChange(of: text) { newValue in
            if newValue.isEmpty {
                amount = 0
                previousValue = newValue
                validValue = false
            } else if let newNumber = Double(newValue) {
                amount = newNumber
                previousValue = newValue
                validValue = true
            } else {
                text = previousValue
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button ("Done") {
                    isTextFieldFocused = false
                }
            }
        }
    }
}
