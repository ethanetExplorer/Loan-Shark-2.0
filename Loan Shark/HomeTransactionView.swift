//import SwiftUI
//struct HomeTransactionView: View {
//
//    @State var transaction: Transaction
//    @State var showTransactionDetailsSheet = false
//
////    var onDelete: (Transaction) -> Void
//
//    var body: some View {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(transaction.name)
//                    ForEach(transaction.people) { person in
//                        Text(person.name)
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }
//                Spacer()
//                Text("$" + String(format: "%.2f", transaction.money))
//                    .foregroundColor(transaction.transactionStatus == .overdue ? Color(red: 0.8, green: 0, blue: 0) : Color(.black))
//                    .font(.title2)
//            }
//        }
//    }
//struct HomeTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTransactionView(transaction: Transaction)
//    }
//}
