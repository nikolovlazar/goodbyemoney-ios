//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Expenses: View {
    @EnvironmentObject var realmManager: RealmManager
    var expenses: [Expense]
    
    @State private var totalExpenses: Double = 0
    @State private var filteredExpenses: [Expense] = []
    @State private var searchQuery = ""
    @State private var timeFilter = Period.week
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 96), spacing: 16), count: 3)
    
    func reloadData() {
        filteredExpenses = filterExpensesInPeriod(period: timeFilter, expenses: realmManager.expenses, periodIndex: 0).expenses
        
        totalExpenses = 0
        
        filteredExpenses.forEach{ expense in
            totalExpenses += expense.amount
        }
    }
    
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
                
                HStack(alignment: .top, spacing: 4) {
                    Text("$")
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                    Text("\(totalExpenses.roundTo(2))")
                        .font(.largeTitle)
                }
                
                ExpensesList(expenses: groupExpensesByDate(filteredExpenses))
                    .id(filteredExpenses)
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
        .onChange(of: timeFilter) { newFilter in
            reloadData()
        }
        .onAppear {
            reloadData()
        }
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        Expenses(expenses: RealmManager().expenses)
    }
}
