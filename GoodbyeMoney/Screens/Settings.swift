//
//  Settings.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI
import RealmSwift

struct Settings: View {
    @State private var showEraseConfirmation = false
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    Categories()
                } label: {
                    HStack {
                        Text("Categories")
                    }
                }
                
                Button(role: .destructive) {
                    showEraseConfirmation = true
                } label: {
                    Text("Erase Data")
                }
                .alert(isPresented: $showEraseConfirmation) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("This action cannot be undone."),
                        primaryButton: .destructive(Text("Erase data")) {
                            let realm = try! Realm()
                            realm.beginWrite()
                            realm.deleteAll()
                            try! realm.commitWrite()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationTitle("Settings")
            .padding(.top, 16)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
