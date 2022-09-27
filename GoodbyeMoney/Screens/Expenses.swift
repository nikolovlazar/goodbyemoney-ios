//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

enum Filter {
    case day, week, month, year
}

struct Expenses: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var searchQuery = ""
    @State private var timeFilter = Filter.week
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 96), spacing: 16), count: 3)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                   Text("Total for:")
                    Picker("", selection: $timeFilter, content: {
                        Text("today").tag(Filter.day)
                        Text("this week").tag(Filter.week)
                        Text("this month").tag(Filter.month)
                        Text("this year").tag(Filter.year)
                    })
                    .foregroundColor(.white)
                }
                
//                LazyVGrid(columns: columns, spacing: 16) {
//                    ForEach(totalsPerCurrency, id: \.currency) {
//                        TotalCurrencyBox(amount: $0.amount, currency: $0.currency)
//                    }
//                }
//                .padding(.horizontal, 16)
                
                ExpensesList(expenses: groupExpensesByDate(realmManager.expenses))
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
