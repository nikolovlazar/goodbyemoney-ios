//
//  Expenses.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Expenses: View {
    var body: some View {
        NavigationView {
            Text("Hello, Expenses!")
                .navigationTitle("Expenses")
        }
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        Expenses()
    }
}
