//
//  ExpensesList.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import SwiftUI

struct ExpensesList: View {
    let expenses = groupExpensesByDate(mockExpenses)
    
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
                        Text("\(getHeaderText(key))")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        ForEach(value, id: \.id) { expense in
                            VStack(spacing: 3) {
                                HStack {
                                    Text(expense.note ?? expense.category.name)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Text("\(expense.currency.rawValue) \(expense.amount.roundTo(2))")
                                }
                                HStack {
                                    Tag(label: expense.category.name, color: expense.category.color)
                                    Spacer()
                                    Text(formatDate(expense.date, format: "HH:mm"))
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 4)
                        }
                        Divider()
                           
                        HStack(alignment: .top) {
                            Text("Total:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                ForEach(totalExpensesByCurrency(value), id: \.key) { key, value in
                                    Text("\(key.rawValue) \(value.roundTo(2))")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.bottom, 12)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesList()
    }
}
