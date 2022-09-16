//
//  Add.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-16.
//

import SwiftUI

enum Currency {
    case USD, CAD, EUR, MKD
}

enum Recurrence {
    case none, daily, weekly, monthly, yearly
}

struct Add: View {
    @State private var amount = ""
    @State private var currency = Currency.USD
    @State private var recurrence = Recurrence.none
    @State private var date = Date()
    @State private var note = ""
    @State private var category = "groceries"
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        let max = Date()
        return min...max
    }
    
    func handleCreate() {
        hideKeyboard()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Text("Amount")
                        Spacer()
                        TextField("Amount", text: $amount)
                            .multilineTextAlignment(.trailing)
                            .submitLabel(.done)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Currency")
                        Spacer()
                        Picker(selection: $currency, label: Text(""), content: {
                            Text("USD").tag(Currency.USD)
                            Text("EUR").tag(Currency.EUR)
                            Text("CAD").tag(Currency.CAD)
                            Text("MKD").tag(Currency.MKD)
                        })
                    }
                    
                    HStack {
                        Text("Recurrence")
                        Spacer()
                        Picker(selection: $recurrence, label: Text(""), content: {
                            Text("None").tag(Recurrence.none)
                            Text("Daily").tag(Recurrence.daily)
                            Text("Weekly").tag(Recurrence.weekly)
                            Text("Monthly").tag(Recurrence.monthly)
                            Text("Yearly").tag(Recurrence.yearly)
                        })
                    }
                    
                    HStack {
                        Text("Date")
                        Spacer()
                        DatePicker(
                            selection: $date,
                            in: dateClosedRange,
                            displayedComponents: .date,
                            label: { Text("") }
                        )
                    }
                    
                    HStack {
                        Text("Note")
                        Spacer()
                        TextField("Note", text: $note)
                            .multilineTextAlignment(.trailing)
                            .submitLabel(.done)
                    }
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker(selection: $category, label: Text(""), content: {
                            Text("Groceries").tag("groceries")
                            Text("Bills").tag("bills")
                            Text("Hobbies").tag("hobbies")
                            Text("Subscriptions").tag("subscriptions")
                            Text("Gas").tag("gas")
                        })
                    }
                }
                .scrollDisabled(true)
                .frame(height: 275)
                
                Button {
                    handleCreate()
                } label: {
                    Label("Submit expense", systemImage: "plus")
                        .labelStyle(.titleOnly)
                        .padding(.horizontal, 44)
                        .padding(.vertical, 12)
                }
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        hideKeyboard()
                    } label: {
                        Label("Dismiss", systemImage: "keyboard.chevron.compact.down")
                    }
                }
            }
            .padding(.top, 16)
            .navigationTitle("Add")
        }
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Add()
    }
}
