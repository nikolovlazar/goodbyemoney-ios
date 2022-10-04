//
//  ExpensesList.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import SwiftUI

struct ExpensesList: View {
    var expenses: [Dictionary<String, [Expense]>.Element]
    
    func getHeaderText(_ date: String) -> String {
        let headerDate = parseDate(date)
        
        if Calendar.current.isDateInToday(headerDate) {
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(headerDate) {
            return "Yesterday"
        }
        
        return date
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(Array(expenses), id: \.key) { key, value in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(getHeaderText(key))")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("USD \(value.map{ $0.amount }.reduce(0, { $0 + $1 }).roundTo(2))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                        
                        ForEach(value, id: \.id) { expense in
                            VStack(spacing: 4) {
                                HStack {
                                    Text(expense.note ?? expense.category!.name)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text("USD \(expense.amount.roundTo(2))")
                                }
                                HStack {
                                    Tag(label: expense.category!.name, color: expense.category!.color)
                                    
                                    if expense.recurrence != nil && expense.recurrence != Recurrence.none {
                                        Image(systemName: "repeat")
                                            .frame(width: 6, height: 6)
                                            .foregroundColor(.secondary)
                                            .padding(.leading, 6)
                                        
                                        Text(expense.recurrence!.rawValue)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                            .padding(.leading, 4)
                                    }
                                    
                                    Spacer()
                                    Text(formatDate(expense.date, format: "HH:mm"))
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 12)
                        }
                    }
                }
            }
            .environment(\.layoutDirection, .leftToRight)
            .padding(.horizontal, 16)
        }
    }
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesList(expenses: [])
    }
}
