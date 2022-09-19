//
//  Date.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import Foundation

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
