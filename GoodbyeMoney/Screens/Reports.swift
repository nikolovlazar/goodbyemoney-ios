//
//  Reports.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Reports: View {
    @EnvironmentObject var realmManager: RealmManager
    @State var period: Period = Period.week

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                PeriodChart(period: period)
                ExpensesBreakdown()
                ExpensesList(expenses: groupExpensesByDate(realmManager.expenses))
            }
            .padding(.top, 16)
            .navigationTitle("Reports")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Picker(selection: $period, label: Text("Period"), content: {
                            Text(Period.week.rawValue).tag(Period.week)
                            Text(Period.month.rawValue).tag(Period.month)
                            Text(Period.year.rawValue).tag(Period.year)
                        })
                    } label: {
                        Label("Period", systemImage: "calendar")
                    }
                }
            }
        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
