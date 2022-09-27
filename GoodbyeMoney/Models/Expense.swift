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
    @Persisted var amount: Double
    @Persisted var category: Category?
    @Persisted var date: Date
    @Persisted var note: String?
    @Persisted var recurrence: Recurrence? = Recurrence.none
    
    convenience init(amount: Double, category: Category, date: Date, note: String? = nil, recurrence: Recurrence? = nil) {
        self.init()
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
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let dayInWeek = dateFormatter.string(from: self.date)
            return dayInWeek
        }
    }
    
    var dayInMonth: Int {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let dayInMonth = Int(dateFormatter.string(from: self.date))!
            return dayInMonth
        }
    }
    
    var month: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let month = dateFormatter.string(from: self.date)
            return month
        }
    }
    
    var year: Int {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let year = Int(dateFormatter.string(from: self.date))!
            return year
        }
    }
}
