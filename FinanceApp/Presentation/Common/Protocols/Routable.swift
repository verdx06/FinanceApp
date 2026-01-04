//
//  Routable.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 03.01.2026.
//

import Foundation

protocol Routable: Hashable, Identifiable {}

extension Routable
{
    var id: String {
        String(describing: self)
    }
}
