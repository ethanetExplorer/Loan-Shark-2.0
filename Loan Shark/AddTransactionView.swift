//
//  AddTransactionView.swift
//  Banker Collab App
//
//  Created by T Krobot on 19/9/22.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State var title = ""
    @State var synchroniseDetails = false
    @State var stringedAmount = ""
    @State var amount: Double = 0

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $title, prompt: Text("Title"))
                    Button {
                        print("change transaction type")
                    } label: {
                        HStack {
                            Text("Transaction Type")
                                .foregroundColor(.black)
                            Spacer()
                            Text("Bill Split")
                                .foregroundColor(.gray)
                        }
                    }
                    Button {
                        print("change tags")
                    } label: {
                        HStack {
                            Text("Tags")
                                .foregroundColor(.black)
                            Spacer()
                            HStack {
                                Text("Select")
                                Image(systemName: "chevron.up.chevron.down")
                                    .padding(.leading, -5)
                                    .font(.system(size: 18))
                            }
                                .foregroundColor(.gray)
                        }
                    }
                    Toggle("Synchronise Details", isOn: $synchroniseDetails)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    Button {
                        print("set reminders")
                    } label: {
                        HStack {
                            Text("Automatically send reminders")
                                .foregroundColor(.black)
                            Spacer()
                            HStack {
                                Text("Select")
                                Image(systemName: "chevron.up.chevron.down")
                                    .padding(.leading, -5)
                                    .font(.system(size: 18))
                            }
                                .foregroundColor(.gray)
                        }
                    }
                }
                Section {
                    Button {
                        print("set reminders")
                    } label: {
                        HStack {
                            Text("Contact")
                                .foregroundColor(.black)
                            Spacer()
                            HStack {
                                Text("Select")
                                Image(systemName: "chevron.up.chevron.down")
                                    .padding(.leading, -5)
                                    .font(.system(size: 18))
                            }
                                .foregroundColor(.gray)
                        }
                    }
                    HStack {
                        Text("S$")
                        TextField("", text: $stringedAmount, prompt: Text("Amount"))
                            .keyboardType(.numberPad)
                            .onSubmit {
                                amount = Double(stringedAmount) ?? 0
                            }
                    }
                    HStack {
                        Text("Due")
                        Spacer()
                        Button {
                            print("choose the due date")
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 120, height: 30)
                                    .foregroundColor(.blue)
                                Text("Choose Date")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                Section {
                    Button {
                        print("show add more contacts view thingy ig")
                    } label: {
                        Text("Add more contacts")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color(red: 244/255, green: 244/255, blue: 248/255))
                    .padding(.top, -25)
                }
                Section {
                    Button {
                        print("save the transaction")
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.blue)
                }
            }
            .navigationTitle("New transaction")
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
