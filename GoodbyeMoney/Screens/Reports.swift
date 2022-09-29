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
    @State var periodIndex = 0
    @State var tabViewSelection = 0
    @State var expenses: [Expense] = []
    
    func filterData(_ index: Int) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        calendar.firstWeekday = 2
        
        var components: DateComponents
        var intervalComponent: Calendar.Component
        
        switch period {
        case Period.week:
            components = DateComponents(weekOfMonth: index)
            intervalComponent = .weekOfMonth
        case Period.month:
            components = DateComponents(month: index)
            intervalComponent = .month
        case Period.year:
            components = DateComponents(year: index)
            intervalComponent = .year
        }
        
        let targetDate = calendar.date(byAdding: components, to: Date())!
        
        let interval = calendar.dateInterval(of: intervalComponent, for: targetDate)!
        
        let startDate = interval.start
        let endDate = interval.end
        
        let range = (startDate ... endDate)
        
        var newExpenses: [Expense] = []
        
        realmManager.expenses.forEach { expense in
            if range.contains(expense.date) {
                newExpenses.append(expense)
            }
        }
        
        expenses = newExpenses
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TabView(selection: $tabViewSelection) {
                    if period == Period.week || period == Period.month {
                        ForEach(
                            (period == Period.week ? -53 : -12)..<1
                        ) { index in
                            VStack {
                                PeriodChart(period: period, expenses: expenses)
                                ExpensesBreakdown()
                            }
                        }
                    } else {
                        PeriodChart(period: period, expenses: expenses)
                        ExpensesBreakdown()
                    }
                }
                .tabViewStyle(.page)
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
        .onAppear {
            filterData(periodIndex)
        }
        .onChange(of: period) { _ in
            filterData(periodIndex)
        }
        .onChange(of: tabViewSelection) { newIndex in
            periodIndex = newIndex * -1
            filterData(newIndex * -1)
        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
