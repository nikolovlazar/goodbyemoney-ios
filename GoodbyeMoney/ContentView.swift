//
//  ContentView.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Expenses()
                .tabItem {
                    Label("Expenses", systemImage: "tray.and.arrow.up.fill")
                }
            
            Reports()
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
            
            Add()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
