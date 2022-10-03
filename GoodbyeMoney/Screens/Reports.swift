//
//  Reports.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Reports: View {
    @EnvironmentObject var realmManager: RealmManager
    @State private var period: Period = Period.week
    @State private var tabViewSelection = 0
    @State private var expenses: [Expense] = []
    @State private var pagesRange = 0..<53
    
    func setPagesRange() {
        switch self.period {
        case .week:
            pagesRange = 0..<53
        case .month:
            pagesRange = 0..<12
        case .year:
            pagesRange = 0..<1
        }
    }
    
    func filterData(_ index: Int) -> [Expense] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        calendar.firstWeekday = 2
        
        var components: DateComponents
        var intervalComponent: Calendar.Component
        
        switch period {
        case Period.week:
            components = DateComponents(weekOfYear: index * -1)
            intervalComponent = .weekOfYear
        case Period.month:
            components = DateComponents(month: index * -1)
            intervalComponent = .month
        case Period.year:
            components = DateComponents(year: index * -1)
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
        
        return newExpenses
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TabView(selection: $tabViewSelection) {
                    ForEach(pagesRange, id: \.self) { index in
                        VStack {
                            PeriodOverview()
                            PeriodChart(period: period, expenses: filterData(index))
                            ExpensesBreakdown()
                        }
                    }
                }
                .environment(\.layoutDirection, .rightToLeft)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .id(pagesRange)
                
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
//        .onAppear {
//            let newIndex = pagesRange.endIndex
//            self.tabViewSelection = newIndex
//        }
        .onChange(of: period) { _ in
            self.tabViewSelection = 0
            setPagesRange()
        }
//        .onChange(of: tabViewSelection) { newIndex in
//            filterData(newIndex * -1)
//        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
