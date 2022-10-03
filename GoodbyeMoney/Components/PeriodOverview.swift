//
//  PeriodOverview.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 3.10.22.
//

import SwiftUI

struct PeriodOverview: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Avg/day")
                    .font(.title3)
                HStack(spacing: 4) {
                    Text("85")
                        .font(.headline)
                    Text("USD")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Text("12 Sep - 18 Sep")
                    .font(.title3)
                HStack(spacing: 4) {
                    Text("+4%")
                        .foregroundColor(.red)
                        .padding(.trailing, 12)
                    Text("850")
                        .font(.headline)
                    Text("USD")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct PeriodOverview_Previews: PreviewProvider {
    static var previews: some View {
        PeriodOverview()
    }
}
