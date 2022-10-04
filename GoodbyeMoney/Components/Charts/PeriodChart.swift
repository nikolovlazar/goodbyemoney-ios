//
//  PeriodChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI

struct PeriodChart: View {
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var periodString: String = ""
    @State private var displayExpenses: [Expense] = []
    @State private var totalForPeriod: Double = 0
    @State private var averageForPeriod: Double = 0
    @State private var daysInMonth: Int = 30
    
    var period: Period = Period.week
    var expenses: [Expense] = []
    var periodIndex: Int = 0
    
    func formatDateRange(startDate: Date, endDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        var format = ""

        switch period {
        case Period.day:
            break
        case Period.week:
            dateFormatter.dateFormat = "d MMM"
            format = "\(dateFormatter.string(from: startDate)) - \(dateFormatter.string(from: endDate))"
        case Period.month:
            dateFormatter.dateFormat = "MMM"
            format = "\(dateFormatter.string(from: startDate))"
        case Period.year:
            dateFormatter.dateFormat = "yyyy"
            format = "\(dateFormatter.string(from: startDate))"
        }
        
        return format
    }
    
    func setupData() {
        let (newExpenses, range) = filterExpensesInPeriod(period: period, expenses: realmManager.expenses, periodIndex: periodIndex)
        var total: Double = 0
        var average: Double = 0

        newExpenses.forEach { expense in
            total += expense.amount
        }

        switch period {
        case Period.day:
            break
        case Period.week:
            average = total / 7
        case Period.month:
            let numOfDays = (Calendar.current.dateComponents([.day], from: range.lowerBound, to: range.upperBound).day!) + 1
            average = total / Double(numOfDays)
            daysInMonth = numOfDays
        case Period.year:
            average = total / 12
        }

        periodString = formatDateRange(startDate: range.lowerBound, endDate: range.upperBound)
        totalForPeriod = total
        averageForPeriod = average
        displayExpenses = newExpenses
    }

    var body: some View {
        VStack {
            PeriodOverview(period: periodString, totalForPeriod: totalForPeriod, averageForPeriod: averageForPeriod)
                .id(displayExpenses)
            switch period {
            case .day:
                Text("")
            case .week:
                WeekChart(expenses: displayExpenses, average: averageForPeriod)
                    .id(displayExpenses)
            case .month:
                MonthChart(expenses: displayExpenses, average: averageForPeriod, daysInMonth: daysInMonth)
                    .id(displayExpenses)
            case .year:
                YearChart(expenses: displayExpenses, average: averageForPeriod)
                    .id(displayExpenses)
            }
            ExpensesBreakdown(expenses: displayExpenses)
            ExpensesList(expenses: groupExpensesByDate(filterExpensesInPeriod(period: period, expenses: displayExpenses, periodIndex: periodIndex).expenses))
        }
        .onAppear {
            setupData()
        }
    }
}

struct PeriodChart_Previews: PreviewProvider {
    static var previews: some View {
        PeriodChart()
    }
}
