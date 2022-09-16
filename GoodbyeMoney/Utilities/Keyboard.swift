//
//  Keyboard.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-16.
//

import UIKit

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
