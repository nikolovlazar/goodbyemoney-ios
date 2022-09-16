//
//  Categories.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//

import SwiftUI

struct Categories: View {
    @State private var isAlertShowing = false
    @State private var newCategoryName: String = ""
    @State private var newCategoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var categories: [Category] = [
        Category(id: 0, name: "Groceries", color: .blue),
        Category(id: 1, name: "Bills", color: .purple),
        Category(id: 2, name: "Subscriptions", color: .red),
    ]
    
    func handleSubmit() {
        if newCategoryName.count > 0 {
            categories.append(Category(
                id: categories.count,
                name: newCategoryName,
                color: newCategoryColor
            ))
            newCategoryName = ""
        } else {
            isAlertShowing = true
        }
    }
    
    func handleDelete(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(categories) { category in
                    HStack {
                        Circle()
                            .frame(width: 12)
                            .foregroundColor(category.color)
                        Text(category.name)
                    }
                }
                .onDelete(perform: handleDelete)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                ColorPicker("", selection: $newCategoryColor, supportsOpacity: false)
                    .labelsHidden()
                    .accessibilityLabel("")

                ZStack(alignment: .trailing) {
                    
                    TextField("New category", text: $newCategoryName)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit {
                            handleSubmit()
                        }
                    
                    if newCategoryName.count > 0 {
                        Button {
                            newCategoryName = ""
                        } label: {
                            Label("Clear input", systemImage: "xmark.circle.fill")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.gray)
                                .padding(.trailing, 6)
                        }
                    }
                }
                
                Button {
                    handleSubmit()
                } label: {
                    Label("Submit", systemImage: "paperplane.fill")
                        .labelStyle(.iconOnly)
                        .padding(6)
                }
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(6)
                .alert("Must provide a category name!", isPresented: $isAlertShowing) {
                    Button("OK", role: .cancel) {
                        isAlertShowing = false
                    }
                }
            }
            .padding(.horizontal, 16)
            .navigationTitle("Categories")
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}