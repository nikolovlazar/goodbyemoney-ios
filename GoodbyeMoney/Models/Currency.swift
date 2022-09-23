//
//  Currency.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-19.
//

import Foundation
import RealmSwift

enum Currency: String, PersistableEnum, CaseIterable {
    case USD = "USD"
    case CAD = "CAD"
    case EUR = "EUR"
    case MKD = "MKD"
}
