//
//  ExpensesBreakdown.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI
import Charts

struct ExpensesBreakdown: View {
    var expenses: [Expense] = []

    var body: some View {
        ScrollView(.horizontal) {
            Chart(expenses) {
                BarMark(
                    x: .value("Amount", $0.amount)
                )
                .foregroundStyle(by: .value("Category", $0.category?.name ?? ""))
            }
            .frame(height: 30)
            .chartXAxis(.hidden)
            .frame(height: 48)
            .padding(.horizontal, 16)
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

struct ExpensesBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesBreakdown()
    }
}
