//
//  PeriodChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI

struct PeriodChart: View {
    var period: Period = Period.week
    var expenses: [Expense] = []
    
    var body: some View {
        WeekChart(expenses: expenses)
    }
}

struct PeriodChart_Previews: PreviewProvider {
    static var previews: some View {
        PeriodChart()
    }
}
