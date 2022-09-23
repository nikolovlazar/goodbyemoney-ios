//
//  WeekChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI
import Charts

typealias WeeklyExpenses = [String: Double]

struct WeekChart: View {
    var expenses: WeeklyExpenses = [
        "Monday": 2860,
        "Tuesday": 465,
        "Wednesday": 613,
        "Thursday": 1140,
        "Friday": 520,
        "Saturday": 850,
        "Sunday": 2079
    ]
    
    func calculateAverage() -> Double {
        return Double((expenses.map { _, value in value }.reduce(0, { $0 + Int($1) })) / expenses.count)
    }

    var body: some View {
        Chart {
            BarMark(
                x: .value("Day", "Monday"),
                y: .value("Amount", expenses["Monday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Tuesday"),
                y: .value("Amount", expenses["Tuesday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Wednesday"),
                y: .value("Amount", expenses["Wednesday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Thursday"),
                y: .value("Amount", expenses["Thursday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Friday"),
                y: .value("Amount", expenses["Friday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Saturday"),
                y: .value("Amount", expenses["Saturday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            BarMark(
                x: .value("Day", "Sunday"),
                y: .value("Amount", expenses["Sunday"]!)
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            RuleMark(y: .value("Daily average", calculateAverage()))
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
            AxisMarks(position: .leading) {
                AxisValueLabel()
                AxisGridLine().foregroundStyle(.clear)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 147)
    }
}

struct WeekChart_Previews: PreviewProvider {
    static var previews: some View {
        WeekChart()
    }
}
