//
//  Period.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-23.
//

import Foundation
import RealmSwift

enum Period: String, PersistableEnum, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
}
