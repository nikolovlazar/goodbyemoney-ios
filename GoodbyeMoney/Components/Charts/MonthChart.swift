//
//  WeekChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI
import Charts

struct MonthChart: View {
    var expenses: [Expense] = []
    var average: Double = 0
    var daysInMonth: Int = 30
    @State var displayExpenses: [Int: Double] = [:]
    
    func calculateTotals() {
        expenses.forEach { expense in
            if displayExpenses[expense.dayInMonth] == nil {
                displayExpenses[expense.dayInMonth] = 0
            }
            let prevValue = displayExpenses[expense.dayInMonth] ?? 0
            
            displayExpenses[expense.dayInMonth] = prevValue + expense.amount
        }
    }

    var body: some View {
        Chart {
            ForEach((1...daysInMonth).reversed(), id: \.self) { day in
                BarMark(
                    x: .value("Day", "\(day)"),
                    y: .value("Amount", displayExpenses[day] ?? 0)
                )
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            RuleMark(y: .value("Daily average", average))
                .foregroundStyle(.gray)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
        }
        .foregroundColor(.white)
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                if let stringValue = value.as(String.self) {
                    if let intValue = Int(stringValue) {
                        if intValue % 5 == 0 {
                            AxisValueLabel {
                                Text(stringValue)
                                    .font(.caption2)
                            }
                        }
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .trailing) {
                AxisValueLabel()
                AxisGridLine().foregroundStyle(.clear)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 147)
        .onAppear {
            calculateTotals()
        }
        .onChange(of: expenses) { _ in
            calculateTotals()
        }
    }
}

struct MonthChart_Previews: PreviewProvider {
    static var previews: some View {
        MonthChart()
    }
}
