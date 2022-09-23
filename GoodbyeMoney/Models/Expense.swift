//
//  Expense.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import SwiftUI
import RealmSwift

class Expense: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var currency: Currency?
    @Persisted var amount: Double
    @Persisted var category: Category?
    @Persisted var date: Date
    @Persisted var note: String?
    @Persisted var recurrence: Recurrence? = Recurrence.none
    
    convenience init(currency: Currency, amount: Double, category: Category, date: Date, note: String? = nil, recurrence: Recurrence? = nil) {
        self.init()
        self.currency = currency
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.recurrence = recurrence
    }
    
    var dayInWeek: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayInWeek = dateFormatter.string(from: self.date)
            return dayInWeek
        }
    }
    
    var dayInMonth: Int {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            let dayInMonth = Int(dateFormatter.string(from: self.date))!
            return dayInMonth
        }
    }
    
    var month: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            let month = dateFormatter.string(from: self.date)
            return month
        }
    }
    
    var year: Int {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyy"
            let year = Int(dateFormatter.string(from: self.date))!
            return year
        }
    }
}
