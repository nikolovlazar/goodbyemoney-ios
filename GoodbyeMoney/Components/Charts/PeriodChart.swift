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
            format = "\(dateFormatter.string(from: startDate)) - \(dateFormatter.string(from: endDate))"
        case Period.year:
            dateFormatter.dateFormat = "yyyy"
            format = "\(dateFormatter.string(from: startDate)) - \(dateFormatter.string(from: endDate))"
        }
        
        return format
    }
    
    func setupData() {
        var (newExpenses, range) = filterExpensesInPeriod(period: period, expenses: realmManager.expenses, periodIndex: periodIndex)
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
            let numOfDays = Calendar.current.dateComponents([.day], from: range.lowerBound, to: range.upperBound).day!
            average = total / Double(numOfDays)
        case Period.year:
            average = total
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
            WeekChart(expenses: displayExpenses, average: averageForPeriod)
                .id(displayExpenses)
            ExpensesBreakdown()
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
