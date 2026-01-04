//
//  MainProfileViewModel+Router.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.12.2025.
//

import Foundation

extension MainProfileViewModel
{
    struct Router
    {
        let logout: () -> Void
        let settingsHandler: () -> Void
        let profileDetailsHandler: () -> Void
    }
}
