//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//
import Sentry
import Foundation

typealias ExpenseInDate = [String: [Expense]]
func groupExpensesByDate(_ expenses: [Expense]) -> [Dictionary<String, [Expense]>.Element] {
    let transaction = SentrySDK.startTransaction(name: "expenses", operation: "render-expenses")
    
    var result: ExpenseInDate = [:]
    
    let groupSpan = transaction.startChild(operation: "group-expenses", description: "group expenses by date")
    for expense in expenses {
        let expenseDate = formatDateToShort(expense.date)
        
        if result[expenseDate] == nil {
            result[expenseDate] = []
        }
        
        result[expenseDate]!.append(expense)
    }
    groupSpan.finish()
    
    let sortSpan = transaction.startChild(operation: "sort-expenses", description: "sort expenses")
    let sorted = result.sorted {
        if ($0.key == "Today" || $0.key == "Yesterday") {
            return true
        }
        
        let date0 = parseDate($0.key)
        let date1 = parseDate($1.key)
        
        return date0.compare(date1) == .orderedDescending
    }
    sortSpan.finish()
    
    transaction.finish()
    
    return sorted
}

func filterExpensesInPeriod(period: Period, expenses: [Expense], periodIndex: Int) -> (expenses: [Expense], range: ClosedRange<Date>) {
    let interval = intervalForPeriod(period: period, periodIndex: periodIndex)
    
    let range = interval.start ... interval.end
    
    var filteredExpenses: [Expense] = []

    expenses.forEach { expense in
        if range.contains(expense.date) {
            filteredExpenses.append(expense)
        }
    }
    
    return (expenses: filteredExpenses, range: range)
}
