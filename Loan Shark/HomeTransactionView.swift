import SwiftUI
struct HomeTransactionView: View {
    
    @Binding var transaction: Transaction
    @State var showTransactionDetailsSheet = false
    
    var onDelete: ((Transaction) -> Void)
    
    var body: some View {
        Button {
            showTransactionDetailsSheet = true
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction.name)
                        .foregroundColor(.black)
                    
                    ForEach(transaction.people) { person in
                        Text(person.name)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                }
                Spacer()
                Text("$" + String(format: "%.2f", transaction.money))
                    .foregroundColor(transaction.transactionStatus == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
                    .font(.title2)
            }
        }
        .sheet(isPresented: $showTransactionDetailsSheet) {
            TransactionDetailSheet(transaction: $transaction) { deletedTransaction in
                onDelete(deletedTransaction)
            }
            .presentationDetents([.fraction(6/7), .fraction(1)])
        }
    }
}
//struct HomeTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTransactionView(transaction: .constant(Transaction(name: "", people: [], money: 0, dueDate: .now)))
//    }
//}
