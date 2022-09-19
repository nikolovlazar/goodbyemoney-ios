//
//  Expense.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import SwiftUI

struct Expense: Identifiable {
    var id: Int
    var currency: Currency
    var amount: Double
    var category: Category
    var date: Date
    var note: String?
    var recurrence: Recurrence? = Recurrence.none
}
