//
//  HomeView.swift
//  Banker Collab App
//
//  Created by T Krobot on 11/9/22.
//

import SwiftUI

struct HomeView: View {

    @State var debts = [
        Debt(money: 420.69, collector: "Mr. Tan", debtor: "me", debtor2: "Mr. Lee", appliedTags: [1, 3], daysDueFromNow: 3),
        Debt(money: 32, collector: "Ah Fan", debtor: "me", debtor2: "Mrs. Koo", appliedTags: [0], daysDueFromNow: 9)
    ]
    @State var debtsDueInAWeek = [
        Debt(money: 420.69, collector: "Mr. Tan", debtor: "me", debtor2: "Mr. Lee", appliedTags: [1, 3], daysDueFromNow: 3)
    ]
    @State var tags = [
        Tag(name: "Bill Split", icon: "square.fill", colour: Color.blue),
        Tag(name: "Normal", icon: "triangle.fill", colour: Color.green),
        Tag(name: "Insurance", icon: "dollarsign.circle", colour: Color.red),
        Tag(name: "Car Fix", icon: "car", colour: Color.orange),
        Tag(name: "Renovation", icon: "hammer.fill", colour: Color.purple)
    ]
    @State var searchTerm = ""
    @State var showTransactionDetailsSheet = false
    @State var showAddTransactionSheet = false
    @State var date = Date()
    @State var calendar = Calendar.current
    @AppStorage ("key") var lastCheckedDay = 0
    @AppStorage ("key") var lastCheckedMonth = 0
    @AppStorage ("key") var lastCheckedYear = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $searchTerm, prompt: Text("Search for something"))
                        .padding(.leading, 30)
                        .disableAutocorrection(true)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                }
                ScrollView(.horizontal) {
                    HStack(spacing: 7) {
                        ForEach(tags) { tag in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.5)
                                    .stroke(tag.colour, lineWidth: 1)
                                    .frame(width: 90, height: 25)
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(tag.colour)
                                    .padding(.trailing, 66)
                                Image(systemName: tag.icon)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 66)
                                    .font(.system(size: 14))
                                    .padding(.bottom, 1)
                                Text(tag.name)
                                    .foregroundColor(tag.colour)
                                    .font(.caption)
                                    .padding(.leading, 20)
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                Section(header: Text("OUTSTANDING")) {
                    ForEach(debts) { debt in
                        Button {
                            showTransactionDetailsSheet.toggle()
                            // decrease debt.daysDueFromNow by dayDifference()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(debt.collector)
                                        .foregroundColor(.black)
                                    Text("\(debt.debtor), \(debt.debtor2) - Tag name")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", debt.money))
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.title2)
                            }
                        }
                        .sheet(isPresented: $showTransactionDetailsSheet) {
                            TransactionDetailsView()
                        }
                    }
                }
                Section(header: Text("DUE IN NEXT 7 DAYS")) {
                    ForEach(debtsDueInAWeek) { debt in
                        Button {
                            showTransactionDetailsSheet.toggle()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(debt.collector)
                                        .foregroundColor(.black)
                                    Text("\(debt.debtor), \(debt.debtor2) - Tag name")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$" + String(format: "%.2f", debt.money))
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.title2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                HStack {
                    Button {
                        showAddTransactionSheet.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                    Button {
                        print("filter search")
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .sheet(isPresented: $showAddTransactionSheet) {
                        AddTransactionView()
                    }
                }
                .font(.system(size: 23))
                .padding(.top, 90)
            }
        }
    }
    
    func dayDifference(notUpdatedDay: Int, notUpdatedMonth: Int, notUpdatedYear: Int) -> Int {
        // set date variables
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        var daysPassedInYear = 0
        var daysPassedInYearNow = 0
        var daysInMonth = 0
        var daysInMonthNow = 0
        var daysInFeb = 28
        var daysInFebNow = 28
        var leapDaysBetween = 0
        
        // find out if it's leap year and set daysInFeb and daysInFebNow
        if year % 4 == 0 {
            if year % 100 == 0 && year % 400 != 0 {
                daysInFebNow = 28
            }
            daysInFebNow = 29
        }

        if notUpdatedYear % 4 == 0 {
            if notUpdatedYear % 100 == 0 && notUpdatedYear % 400 != 0 {
                daysInFeb = 28
            }
            daysInFeb = 29
        }
        
        // find out days in current month
        if month == 2 {
            daysInMonthNow = daysInFebNow
        } else if month != 4 || month != 6 || month != 9 || month != 11 {
            daysInMonthNow = 30
        } else {
            daysInMonthNow = 31
        }

        if notUpdatedMonth == 2 {
            daysInMonth = daysInFeb
        } else if notUpdatedMonth != 4 || notUpdatedMonth != 6 || notUpdatedMonth != 9 || notUpdatedMonth != 11 {
            daysInMonth = 30
        } else {
            daysInMonth = 31
        }
        
        // set daysPassedInYear and daysPassedInYearNow based on day and month
        if notUpdatedMonth > 1 {
            if notUpdatedMonth % 2 == 0 {
                daysPassedInYear = (61 * (notUpdatedMonth - 2)) - daysInMonth + notUpdatedDay + daysInFeb + 31
            } else {
                daysPassedInYear = (61 * (notUpdatedMonth - 3)) + notUpdatedDay + daysInFeb + 31
            }
        } else {
            daysPassedInYear = notUpdatedDay
        }
        
        if month > 1 {
            if month % 2 == 0 {
                daysPassedInYearNow = (61 * (month - 2)) - daysInMonthNow + day + daysInFebNow + 31
            } else {
                daysPassedInYearNow = (61 * (month - 3)) + day + daysInFebNow + 31
            }
        } else {
            daysPassedInYear = day
        }
        
        // return days that passed since last check
        if year == notUpdatedYear {
            return daysPassedInYearNow - daysPassedInYear
        } else {
            for year in notUpdatedYear + 1..<year {
                if year % 4 == 0 {
                    if year % 100 == 0 && year % 400 != 0 {
                        leapDaysBetween -= 1
                    }
                    leapDaysBetween += 1
                }
            }
            if daysInFeb == 29 {
                if notUpdatedMonth == 2 && notUpdatedDay <= 28 {
                    leapDaysBetween += 1
                } else if notUpdatedMonth == 1  {
                    leapDaysBetween += 1
                }
            }
            return daysPassedInYearNow - daysPassedInYear + (365 * (year - notUpdatedYear - 1)) + leapDaysBetween
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
