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
    @State var showToolbar: Bool = true
    var hasExistingValue: Bool {
        if amount != 0 {
            return true
        } else {
            return false
        }
    }
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
            if hasExistingValue || validValue == true {
                let number = decimalNumberFormat.string(for: amount)!
                text = number
                previousValue = text
            } else {
                text = ""
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
        .toolbar {
            if showToolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button ("Done") {
                        isTextFieldFocused = false
                        showToolbar = false
                    }
                }
            }
        }
    }
}
