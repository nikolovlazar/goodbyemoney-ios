//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import Foundation

typealias ExpenseInDate = [String: [Expense]]
func groupExpensesByDate(_ expenses: [Expense]) -> [Dictionary<String, [Expense]>.Element] {
    var result: ExpenseInDate = [:]
    
    for expense in expenses {
        let expenseDate = formatDateToShort(expense.date)
        
        if result[expenseDate] == nil {
            result[expenseDate] = []
        }
        
        result[expenseDate]!.append(expense)
    }
    
    let sorted = result.sorted {
        if ($0.key == "Today" || $0.key == "Yesterday") {
            return true
        }
        
        let date0 = parseDate($0.key)
        let date1 = parseDate($1.key)
        
        return date0.compare(date1) == .orderedDescending
    }
    
    return sorted
}

typealias ExpenseInCurrency = [Currency: Double]
func totalExpensesByCurrency(_ expenses: [Expense]) -> [Dictionary<Currency, Double>.Element] {
    var result: ExpenseInCurrency = [:]
    
    for expense in expenses {
        if result[expense.currency] == nil {
            result[expense.currency] = 0
        }
        
        result[expense.currency] = result[expense.currency]! + expense.amount
    }
    
    let sorted = result.sorted {
        return $0.key.rawValue.compare($1.key.rawValue) == .orderedDescending
    }
    
    return sorted
}
