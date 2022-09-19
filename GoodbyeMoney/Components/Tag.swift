//
//  Chip.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import SwiftUI

struct Tag: View {
    var label: String
    var color: Color
    
    var body: some View {
        Text(label)
            .font(.footnote)
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.4))
            .cornerRadius(8)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(label: "Takeout", color: .yellow)
    }
}
