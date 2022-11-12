//
//  TransactionDetailSheet.swift
//  Loan Shark
//
//  Created by Yuhan Du on 12/11/22.
//

import SwiftUI

struct TransactionDetailSheet: View {
    
    @Binding var transaction: Transaction
    
    var body: some View {
        NavigationView {
            
        }
        .navigationTitle($transaction.name)
    }
}

//struct TransactionDetailSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionDetailSheet(transaction: $transaction)
//    }
//}
