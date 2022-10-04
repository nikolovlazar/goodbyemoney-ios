//
//  WeekChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI
import Charts

struct YearChart: View {
    var expenses: [Expense] = []
    var average: Double = 0
    @State var displayExpenses: [String: Double] = [:]
    
    func calculateTotals() {
        expenses.forEach { expense in
            if displayExpenses[expense.month] == nil {
                displayExpenses[expense.month] = 0
            }
            let prevValue = displayExpenses[expense.month] ?? 0
            
            displayExpenses[expense.month] = prevValue + expense.amount
        }
    }

    var body: some View {
        Chart {
            BarMark(
                x: .value("Month", "Dec"),
                y: .value("Amount", displayExpenses["Dec"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Nov"),
                y: .value("Amount", displayExpenses["Nov"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Oct"),
                y: .value("Amount", displayExpenses["Oct"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Sep"),
                y: .value("Amount", displayExpenses["Sep"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Aug"),
                y: .value("Amount", displayExpenses["Aug"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Jul"),
                y: .value("Amount", displayExpenses["Jul"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Jun"),
                y: .value("Amount", displayExpenses["Jun"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "May"),
                y: .value("Amount", displayExpenses["May"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Apr"),
                y: .value("Amount", displayExpenses["Apr"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Mar"),
                y: .value("Amount", displayExpenses["Mar"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Feb"),
                y: .value("Amount", displayExpenses["Feb"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Month", "Jan"),
                y: .value("Amount", displayExpenses["Jan"] ?? 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            RuleMark(y: .value("Monthly average", average))
                .foregroundStyle(.gray)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
        }
        .foregroundColor(.white)
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel() {
                    if let stringValue = value.as(String.self) {
                        Text(stringValue)
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

struct YearChart_Previews: PreviewProvider {
    static var previews: some View {
        YearChart()
    }
}
