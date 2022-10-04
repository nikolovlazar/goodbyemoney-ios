//
//  PeriodOverview.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 3.10.22.
//

import SwiftUI

struct PeriodOverview: View {
    var period: String
    var totalForPeriod: Double
    var averageForPeriod: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(period)
                    .font(.title3)
                HStack(spacing: 4) {
                    Text("\(totalForPeriod.roundTo(2))")
                        .font(.headline)
                    Text("USD")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text("Avg/day")
                    .font(.title3)
                HStack(spacing: 4) {
                    Text("\(averageForPeriod.roundTo(2))")
                        .font(.headline)
                    Text("USD")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .padding(.horizontal, 16)
    }
}

struct PeriodOverview_Previews: PreviewProvider {
    static var previews: some View {
        PeriodOverview(period: "12 Sep - 18 Sep", totalForPeriod: 85, averageForPeriod: 12)
    }
}
