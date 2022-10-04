//
//  WeekChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI
import Charts

struct WeekChart: View {
    var expenses: [Expense] = []
    var average: Double = 0
    @State var displayExpenses: [String: Double] = [:]
    
    func calculateTotals() {
        expenses.forEach { expense in
            if displayExpenses[expense.dayInWeek] == nil {
                displayExpenses[expense.dayInWeek] = 0
            }
            let prevValue = displayExpenses[expense.dayInWeek] ?? 0
            
            displayExpenses[expense.dayInWeek] = prevValue + expense.amount
        }
    }

    var body: some View {
        Chart {
            BarMark(
                x: .value("Day", "Sunday"),
                y: .value("Amount", displayExpenses["Sunday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Saturday"),
                y: .value("Amount", displayExpenses["Saturday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Friday"),
                y: .value("Amount", displayExpenses["Friday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Thursday"),
                y: .value("Amount", displayExpenses["Thursday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Wednesday"),
                y: .value("Amount", displayExpenses["Wednesday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Tuesday"),
                y: .value("Amount", displayExpenses["Tuesday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Monday"),
                y: .value("Amount", displayExpenses["Monday"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            RuleMark(y: .value("Daily average", average))
                .foregroundStyle(.gray)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
        }
        .foregroundColor(.white)
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel() {
                    if let stringValue = value.as(String.self) {
                        Text(stringValue.prefix(1))
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

struct WeekChart_Previews: PreviewProvider {
    static var previews: some View {
        WeekChart()
    }
}
