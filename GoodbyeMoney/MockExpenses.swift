//
//  MockExpenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import Foundation

let mockExpenses: [Expense] = [
    Expense(
        id: 0,
        currency: Currency.MKD,
        amount: 660,
        category: Category(name: "Takeout", color: .yellow),
        date: Calendar.current.date(bySettingHour: 16, minute: 24, second: 13, of: Date())!,
        note: "Pizza"
    ),
    Expense(
        id: 1,
        currency: Currency.USD,
        amount: 35,
        category: Category(name: "Electronics", color: .green),
        date: Calendar.current.date(bySettingHour: 13, minute: 37, second: 24, of: Date())!,
        note: "Mouse pad"
    ),
    Expense(
        id: 2,
        currency: Currency.MKD,
        amount: 1200,
        category: Category(name: "Groceries", color: .blue),
        date: Calendar.current.date(bySettingHour: 15, minute: 22, second: 38, of: Date())!
    ),
    Expense(
        id: 3,
        currency: Currency.MKD,
        amount: 1000,
        category: Category(name: "Bills", color: .red),
        date: Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: Date())!,
        note: "Internet",
        recurrence: Recurrence.monthly
    ),
    Expense(
        id: 4,
        currency: Currency.MKD,
        amount: 150,
        category: Category(name: "Groceries", color: .blue),
        date: Calendar.current.date(bySettingHour: 11, minute: 32, second: 07, of: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)!,
        note: "Milk + Eggs"
    ),
    Expense(
        id: 5,
        currency: Currency.MKD,
        amount: 315,
        category: Category(name: "Bills", color: .red),
        date: Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)!,
        note: "Water",
        recurrence: Recurrence.monthly
    ),
    Expense(
        id: 6,
        currency: Currency.CAD,
        amount: 119,
        category: Category(name: "Electronics", color: .green),
        date: Calendar.current.date(bySettingHour: 18, minute: 52, second: 48, of: Calendar.current.date(byAdding: .day, value: -5, to: Date())!)!,
        note: "Magic mouse"
    ),
    Expense(
        id: 7,
        currency: Currency.USD,
        amount: 30,
        category: Category(name: "Takeout", color: .yellow),
        date: Calendar.current.date(bySettingHour: 21, minute: 13, second: 22, of: Calendar.current.date(byAdding: .day, value: -5, to: Date())!)!,
        note: "Burgers"
    ),
    Expense(
        id: 7,
        currency: Currency.USD,
        amount: 30,
        category: Category(name: "Takeout", color: .yellow),
        date: Calendar.current.date(bySettingHour: 21, minute: 13, second: 22, of: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)!,
        note: "Burgers"
    )
]
