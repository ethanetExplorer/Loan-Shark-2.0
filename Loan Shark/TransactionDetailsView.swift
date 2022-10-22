//
//  TransactionDetailsView.swift
//  Banker Collab App
//
//  Created by T Krobot on 12/9/22.
//

import SwiftUI
import WrappingHStack

struct TransactionDetailsView: View {
    
    @Environment (\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("TRANSACTION TYPE")) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12.5)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 80, height: 25)
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.blue)
                            .padding(.trailing, 56)
                        Image(systemName: "square.fill")
                            .foregroundColor(.white)
                            .padding(.trailing, 56)
                            .font(.system(size: 14))
                            .padding(.bottom, 1)
                        Text("Bill Split")
                            .foregroundColor(.blue)
                            .font(.caption)
                            .padding(.leading, 20)
                    }
                }
                Section(header: Text("UNPAID")) {
                    Text("Unpaid people")
                }
                Section(header: Text("PAID")) {
                    Text("Here are the lucky people who were paid")
                }
            }
        }
        Button {
            dismiss()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 50)
                Text("Close")
                    .foregroundColor(.white)
            }
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView()
    }
}
