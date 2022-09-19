//
//  Date.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import Foundation

func parseDate(_ date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "E, d MMM yyyy"
    
    var parsedDate = dateFormatter.date(from: date)
    
    if parsedDate == nil {
        let currentYear = Calendar.current.component(.year, from: Date())
        dateFormatter.dateFormat = "E, d MMM"
        parsedDate = dateFormatter.date(from: date)
        
        var components = Calendar.current.dateComponents([.year, .day, .month], from: parsedDate!)
        components.setValue(currentYear, for: .year)
        
        parsedDate = Calendar.current.date(from: components)
    }
    
    return parsedDate!
}

func formatDateToShort(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, d MMM yyyy"
    
    let dateYear = Calendar.current.dateComponents([.year], from: date).year
    let thisYear = Calendar.current.dateComponents([.year], from: Date()).year
    
    if dateYear == thisYear {
        formatter.dateFormat = "E, d MMM"
    }
    
    return formatter.string(from: date)
}

func formatDate(_ date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.string(from: date)
}
