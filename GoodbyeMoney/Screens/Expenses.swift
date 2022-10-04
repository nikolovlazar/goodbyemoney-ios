//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Expenses: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var searchQuery = ""
    @State private var timeFilter = Period.week
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 96), spacing: 16), count: 3)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                   Text("Total for:")
                    Picker("", selection: $timeFilter, content: {
                        Text("today").tag(Period.day)
                        Text("this week").tag(Period.week)
                        Text("this month").tag(Period.month)
                        Text("this year").tag(Period.year)
                    })
                    .foregroundColor(.white)
                }
                
                ExpensesList(expenses: groupExpensesByDate(filterExpensesInPeriod(period: timeFilter, expenses: realmManager.expenses, periodIndex: 0).expenses))
            }
            .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
            .navigationTitle("Expenses")
        }
        .searchable(
            text: $searchQuery,
            placement: .automatic,
            prompt: "Search expenses"
        )
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        Expenses()
    }
}
