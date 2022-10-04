//
//  ContentView.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var realmManager = RealmManager()

    var body: some View {
        TabView {
            Expenses(expenses: realmManager.expenses)
                .environmentObject(realmManager)
                .tabItem {
                    Label("Expenses", systemImage: "tray.and.arrow.up.fill")
                }
            
            Reports()
                .environmentObject(realmManager)
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
            
            Add()
                .environmentObject(realmManager)
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
            
            Settings()
                .environmentObject(realmManager)
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
