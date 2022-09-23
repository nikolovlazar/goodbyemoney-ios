//
//  PeriodChart.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import SwiftUI

struct PeriodChart: View {
    var period: Period = Period.week
    
    var body: some View {
        WeekChart()
    }
}

struct PeriodChart_Previews: PreviewProvider {
    static var previews: some View {
        PeriodChart()
    }
}
